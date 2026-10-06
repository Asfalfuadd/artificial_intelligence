from database import get_connection

# GET GEJALA
# Mengambil semua gejala dari database, diurutkan berdasarkan kode.
# Return: dict { "G01": "Lampu indikator tidak menyala", ... }
def get_gejala():

    conn = get_connection()
    cur  = conn.cursor()

    cur.execute(
        """
        SELECT *
        FROM gejala
        ORDER BY kode ASC
        """
    )

    data = cur.fetchall()

    conn.close()

    return {
        row["kode"]: row["nama"]
        for row in data
    }

# GET KATEGORI GEJALA
# Mengambil pengelompokan gejala per kategori.
# Return: dict { "Power & Daya": ["G01", "G04", ...], ... }
def get_kategori_gejala():

    conn = get_connection()
    cur  = conn.cursor()

    cur.execute(
        """
        SELECT
            kategori,
            gejala_kode
        FROM kategori_gejala
        ORDER BY kategori
        """
    )

    rows = cur.fetchall()

    conn.close()

    hasil = {}

    for row in rows:

        kategori = row["kategori"]

        if kategori not in hasil:
            hasil[kategori] = []

        hasil[kategori].append(row["gejala_kode"])

    return hasil

# GET KERUSAKAN
# Mengambil semua data kerusakan dari database.
# Kolom solusi dipisah dengan karakter "|" (sesuai DB).
# Return: dict { "K01": { nama, deskripsi, solusi, icon }, ... }
def get_kerusakan():

    conn = get_connection()
    cur  = conn.cursor()

    cur.execute(
        """
        SELECT *
        FROM kerusakan
        ORDER BY kode ASC
        """
    )

    data = cur.fetchall()

    conn.close()

    hasil = {}

    for row in data:

        # Pemisah solusi di database menggunakan "|" (satu pipe)
        solusi_list = [
            s.strip()
            for s in row["solusi"].split("|")
            if s.strip()
        ]

        hasil[row["kode"]] = {
            "nama":      row["nama"],
            "deskripsi": row["deskripsi"],
            "solusi":    solusi_list,
            "icon":      row["icon"],
        }

    return hasil
# GET RULES
# Mengambil semua rules dari tabel `rules` beserta kondisinya dari tabel `conditions`.

def get_rules():

    conn = get_connection()
    cur  = conn.cursor()

    cur.execute(
        """
        SELECT id, kerusakan_kode
        FROM rules
        ORDER BY id ASC
        """
    )

    rules = cur.fetchall()

    hasil = []

    for rule in rules:

        rule_id = rule["id"]

        # Ambil semua conditions untuk rule ini
        cur.execute(
            """
            SELECT
                gejala_kode,
                condition_type,
                operator_type
            FROM conditions
            WHERE rule_id = %s
            ORDER BY id ASC
            """,
            (rule_id,)
        )

        conditions = cur.fetchall()

        required = []  # Harus terpenuhi SEMUA (AND)
        support  = []  # Pendukung untuk menambah confidence

        for c in conditions:

            if c["condition_type"] == "required":
                required.append(c["gejala_kode"])

            elif c["condition_type"] == "support":
                support.append(c["gejala_kode"])

        hasil.append({
            "id":        rule_id,
            "kerusakan": rule["kerusakan_kode"],
            "required":  required,
            "support":   support,
        })

    conn.close()

    return hasil