from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    session
)

from engine.knowledge_base import (
    get_gejala,
    get_kategori_gejala,
)

from engine.inference import diagnosa

app = Flask(__name__)

app.secret_key = "diginosa-secret-key-2026"

# HOME
@app.route("/")
def index():

    gejala = get_gejala()

    kategori = get_kategori_gejala()

    stats = {

        "total_gejala": len(gejala),

        "total_kerusakan": 10,

        "total_kategori": len(kategori),
    }

    return render_template(
        "index.html",
        stats=stats
    )

# HALAMAN DIAGNOSA
@app.route("/diagnosa", methods=["GET"])
def halaman_diagnosa():

    return render_template(

        "diagnosa.html",

        gejala=get_gejala(),

        kategori=get_kategori_gejala(),
    )

# PROSES DIAGNOSA
@app.route("/diagnosa", methods=["POST"])
def proses_diagnosa():

    gejala_terpilih = request.form.getlist("gejala")

    if not gejala_terpilih:

        return render_template(

            "diagnosa.html",

            gejala=get_gejala(),

            kategori=get_kategori_gejala(),

            error="Silakan pilih minimal satu gejala"
        )

    # PROSES INFERENCE
    data_diagnosa = diagnosa(
        gejala_terpilih
    )

    hasil = data_diagnosa["hasil"]

    reasoning_steps = data_diagnosa[
        "reasoning_steps"
    ]

    # SIMPAN KE SESSION
    session["hasil"] = hasil

    session["reasoning_steps"] = reasoning_steps

    session["gejala_terpilih"] = gejala_terpilih

    return redirect(
        url_for("halaman_hasil")
    )

# HALAMAN HASIL
@app.route("/hasil")
def halaman_hasil():

    hasil = session.get("hasil", [])

    reasoning_steps = session.get(
        "reasoning_steps",
        []
    )

    gejala_terpilih = session.get(
        "gejala_terpilih",
        []
    )

    gejala_all = get_gejala()

    gejala_detail = {

        kode: gejala_all.get(kode, kode)

        for kode in gejala_terpilih
    }

    return render_template(

        "hasil.html",

        hasil=hasil,

        reasoning_steps=reasoning_steps,

        gejala_terpilih=gejala_terpilih,

        gejala_detail=gejala_detail,

        gejala_all=gejala_all,
    )

# RUN APP
if __name__ == "__main__":

    app.run(debug=True)