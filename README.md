chinparu-agent/
├── contracts/
│   └── ChinparuTokenV2.sol
└── agent/
    ├── main.py
    ├── abi.json            # Platzhalter – nach Deployment einfügen
    ├── requirements.txt
    └── .env                # Konfigurationsdatei (nicht committen!)
├── .gitignore
└── README.md
agent/.env
agent/abi.json
# Chinparu Agent

📦 KI-gesteuertes Setup für deinen Chinparu Token auf Sepolia.

## 🧩 Projektstruktur

- contracts/ChinparuTokenV2.sol – smarter Token-Contract  
- agent/main.py – Python-Agent mit OpenAI-Logik  
- agent/requirements.txt – benötigte Python-Pakete  

## 🚀 Deployment & Setup

1. Deploy `ChinparuTokenV2.sol` auf Sepolia über Remix.
2. ABI exportieren → `agent/abi.json` ablegen.
3. `.env` in `agent/` anlegen mit Variablen:
4. Python-Agent installieren und starten:
```bash
cd agent
pip install -r requirements.txt
python main.py

---

### 4️⃣ Code & Anleitung zum Setup

- `contracts/ChinparuTokenV2.sol`: Smart Contract mit `performAction(...)`
- `agent/main.py`: Python-Agent
- `agent/requirements.txt`
- `.gitignore` sorgt für Sicherheit
- `README.md` erklärt alles Schritt für Schritt

---

## ✅ Jetzt übernehmen – so geht’s:

1. **Neues Repo erstellen** auf GitHub: z. B. `chinparu-agent`
2. Im Terminal:

```bash
git init
git remote add origin https://github.com/dein-username/chinparu-agent.git
git add .
git commit -m "Initial Chinparu Agent setup"
git branch -M main
git push -u origin main
