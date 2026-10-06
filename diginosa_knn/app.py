from flask import Flask, render_template, request
import mysql.connector
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score

app = Flask(__name__)

K_VAL_DEFAULT = 3

# === KAMUS PENERJEMAH LENGKAP KODE GEJALA (G01 - G39) ===
KAMUS_GEJALA = {
    'G01': 'Lampu indikator mati', 'G02': 'Tampilan hilang', 'G03': 'CMOS lemah',
    'G04': 'Restart sendiri', 'G05': 'Hang', 'G06': 'HDD tidak detek',
    'G07': 'Blue screen', 'G08': 'Tidak charging', 'G09': 'Charger berkedip',
    'G10': 'Mati saat menyala', 'G11': 'Mati total', 'G12': 'Gagal booting',
    'G13': 'Layar blank', 'G14': 'Layar bergaris', 'G15': 'Tidak ada arus',
    'G16': 'Sistem lambat', 'G17': 'Suara aneh', 'G18': 'Gagal masuk Windows',
    'G19': 'Disk error', 'G20': 'Retry boot disk', 'G21': 'Gagal install OS',
    'G22': 'Bunyi beep', 'G23': 'Keyboard mati', 'G24': 'Touchpad mati',
    'G25': 'Tombol sebagian mati', 'G26': 'Salah input', 'G27': 'Mengetik sendiri',
    'G28': 'Tombol Fn mati', 'G29': 'Layar redup', 'G30': 'Layar gelap',
    'G31': 'Garis layar', 'G32': 'Layar tidak tampil sebagian', 'G33': 'Indikator baterai mati',
    'G34': 'Tanda silang baterai', 'G35': 'Baterai tidak penuh', 'G36': 'Tidak bisa charge ulang',
    'G37': 'Mati saat dicas', 'G38': 'Terkena virus', 'G39': 'Gagal update Windows'
}

def get_db_connection():
    return mysql.connector.connect(
        host="localhost", user="root", password="", database="db_diagnosa_laptop_ml"
    )

def train_knn_model(k_value):
    conn = get_db_connection()
    df = pd.read_sql("SELECT * FROM tbl_dataset_ml", conn)
    conn.close()
    fitur_kolom = [col for col in df.columns if col.upper().startswith('G')]
    X = df[fitur_kolom]
    kolom_target = [col for col in df.columns if 'kerusakan' in col.lower() or 'kode' in col.lower()][0]
    y = df[kolom_target]
    
    model_knn = KNeighborsClassifier(n_neighbors=k_value, metric='euclidean')
    model_knn.fit(X, y)
    y_pred = model_knn.predict(X)
    
    metrik = {
        'accuracy': int(round(accuracy_score(y, y_pred) * 100)),
        'precision': int(round(precision_score(y, y_pred, average='macro', zero_division=0) * 100)),
        'recall': int(round(recall_score(y, y_pred, average='macro', zero_division=0) * 100))
    }
    return model_knn, metrik, fitur_kolom

# 1. RUTE HALAMAN UTAMA (HOME)
@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')

# 2. RUTE HALAMAN DIAGNOSA
@app.route('/diagnosa', methods=['GET', 'POST'])
def diagnosa():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    current_k = int(request.form.get('k_value', K_VAL_DEFAULT))
    
    try:
        model_knn, metrik_evaluasi, daftar_gejala = train_knn_model(k_value=current_k)
    except Exception:
        metrik_evaluasi = {'accuracy': 0, 'precision': 0, 'recall': 0}
        daftar_gejala = []
        
    hasil_diagnosa = None
    gejala_dipilih = []
    
    if request.method == 'POST':
        gejala_dipilih = request.form.getlist('gejala')
        input_user = [1 if g in gejala_dipilih else 0 for g in daftar_gejala]
        
        if any(input_user) and daftar_gejala:
            prediksi_kode = model_knn.predict([input_user])[0]
            cursor.execute("SELECT * FROM tbl_kerusakan WHERE kode = %s", (prediksi_kode,))
            kerusakan = cursor.fetchone()
            
            if kerusakan:
                hasil_diagnosa = {
                    'nama': kerusakan.get('nama_kerusakan'),
                    'deskripsi': kerusakan.get('deskripsi'),
                    'solusi': (kerusakan.get('solusi') or '').split('|')
                }
    
    cursor.close()
    conn.close()
    return render_template('diagnosa.html', 
                           metrik=metrik_evaluasi, 
                           k_value=current_k, 
                           hasil=hasil_diagnosa, 
                           gejala_dipilih=gejala_dipilih, 
                           daftar_gejala=daftar_gejala, 
                           kamus_gejala=KAMUS_GEJALA)

# 3. RUTE HALAMAN LAYANAN
@app.route('/layanan', methods=['GET'])
def layanan():
    return render_template('layanan.html')

# 4. RUTE HALAMAN KONTAK
@app.route('/kontak', methods=['GET'])
def kontak():
    return render_template('kontak.html')

if __name__ == '__main__':
    app.run(debug=True)