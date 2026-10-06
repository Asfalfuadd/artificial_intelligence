from engine.knowledge_base import (
    get_rules,
    get_kerusakan,
    get_gejala,
)

# EVALUASI KONDISI AND (Nested-ready)
# Menerima list gejala required dan set gejala pengguna.
# Operator AND: SEMUA gejala required harus terpenuhi.
def evaluate_and_conditions(required, gejala_set):
    hasil_evaluasi = []
    for g in required:
        terpenuhi = g in gejala_set
        hasil_evaluasi.append({
            "kode": g,
            "terpenuhi": terpenuhi,
        })
    semua_terpenuhi = all(
        e["terpenuhi"] for e in hasil_evaluasi
    )
    return semua_terpenuhi, hasil_evaluasi

# FUNGSI UTAMA DIAGNOSA
def diagnosa(gejala_terpilih):

    RULES    = get_rules()
    KERUSAKAN = get_kerusakan()
    GEJALA_ALL = get_gejala()

    gejala_set = set(gejala_terpilih)

    hasil          = []
    reasoning_steps = []

    # Inisialisasi Working Memory (Forward Chaining)
    reasoning_steps.append(
        "=== FORWARD CHAINING DIMULAI ==="
    )

    reasoning_steps.append(
        f"Working Memory: {', '.join(sorted(gejala_set))}"
    )

    reasoning_steps.append(
        f"Total rule tersedia: {len(RULES)}"
    )

    reasoning_steps.append("---")

    # Iterasi setiap rule dari database
    for rule in RULES:

        rule_id  = rule["id"]
        required = rule["required"]   # kondisi AND wajib
        support  = rule["support"]    # kondisi pendukung
        kode_kerusakan = rule["kerusakan"]

        nama_kerusakan = KERUSAKAN[kode_kerusakan]["nama"] \
            if kode_kerusakan in KERUSAKAN else kode_kerusakan

        # ---- Header cek rule ----
        reasoning_steps.append(
            f"[Rule {rule_id}] Target: {nama_kerusakan} ({kode_kerusakan})"
        )

        # ---- Bangun klausa IF ----
        klausa_required = " AND ".join(
            [f"{g} ({GEJALA_ALL.get(g, g)})" for g in required]
        )

        reasoning_steps.append(
            f"  IF {klausa_required}"
        )

        # ---- Evaluasi AND conditions ----
        cocok, detail_eval = evaluate_and_conditions(
            required, gejala_set
        )

        for ev in detail_eval:

            status = "✔ TERPENUHI" if ev["terpenuhi"] else "✘ TIDAK TERPENUHI"
            nama_g = GEJALA_ALL.get(ev["kode"], ev["kode"])

            reasoning_steps.append(
                f"    • {ev['kode']} ({nama_g}): {status}"
            )

        # ---- Hasil evaluasi rule ----
        if not cocok:

            reasoning_steps.append(
                f"  → Rule {rule_id} TIDAK COCOK "
                f"(kondisi AND tidak terpenuhi semua)"
            )
            reasoning_steps.append("---")
            continue

        # ---- Rule cocok: hitung support dan confidence ----
        reasoning_steps.append(
            f"  → Rule {rule_id} COCOK — semua kondisi AND terpenuhi"
        )

        support_match = [
            s for s in support if s in gejala_set
        ]

        # Confidence: 70% base + hingga 30% dari support
        confidence = 70

        if len(support) > 0:

            bonus = round(
                (len(support_match) / len(support)) * 30, 1
            )

            confidence += bonus

            reasoning_steps.append(
                f"  Support terpenuhi: "
                f"{len(support_match)}/{len(support)} "
                f"→ bonus {bonus}%"
            )

        reasoning_steps.append(
            f"  THEN {kode_kerusakan} ({nama_kerusakan})"
        )

        reasoning_steps.append(
            f"  Confidence akhir: {confidence}%"
        )

        reasoning_steps.append("---")

        # ---- Simpan ke hasil ----
        data = KERUSAKAN[kode_kerusakan]

        # Penjelasan reasoning per item (tampil di kartu hasil)
        detail_reasoning = [

            f"Rule {rule_id} aktif: "
            f"IF {' AND '.join(required)} "
            f"THEN {kode_kerusakan}",

            f"Kondisi AND ({len(required)} syarat): "
            + " AND ".join([
                f"{g} ✔" for g in required
            ]),

            f"Gejala pendukung terpenuhi: "
            f"{len(support_match)} dari {len(support)} "
            f"({'kosong' if not support else ', '.join(support_match) if support_match else 'tidak ada'})",

            f"Confidence = 70% (base)"
            + (
                f" + {round((len(support_match)/len(support))*30, 1)}% (support)"
                if len(support) > 0 else ""
            )
            + f" = {confidence}%",
        ]

        hasil.append({
            "kode":          kode_kerusakan,
            "nama":          data["nama"],
            "deskripsi":     data["deskripsi"],
            "solusi":        data["solusi"],
            "icon":          data["icon"],
            "confidence":    confidence,
            "rule_id":       rule_id,
            "required":      required,
            "support_match": support_match,
            "gejala_cocok":  required + support_match,
            "reasoning":     detail_reasoning,
        })

    # Hapus duplikat kerusakan — ambil confidence tertinggi
    seen      = {}
    hasil_unik = []

    for item in hasil:

        k = item["kode"]

        if k not in seen or item["confidence"] > seen[k]["confidence"]:
            seen[k] = item

    hasil_unik = sorted(
        seen.values(),
        key=lambda x: x["confidence"],
        reverse=True,
    )

    reasoning_steps.append(
        f"=== HASIL: {len(hasil_unik)} kerusakan teridentifikasi ==="
    )

    for item in hasil_unik:

        reasoning_steps.append(
            f"  • {item['kode']} — {item['nama']} "
            f"(confidence {item['confidence']}%)"
        )

    return {
        "hasil":           hasil_unik,
        "reasoning_steps": reasoning_steps,
    }