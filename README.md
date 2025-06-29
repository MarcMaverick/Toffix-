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



1. Deploy `ChinparuTokenV2.sol` auf Sepolia über Remix.
2. ABI exportieren → `agent/abi.json` ablegen.
3. `.env` in `agent/` anlegen mit Variablen:
4. Python-Agent installieren und starten:
```bash
cd agent
pip install -r requirements.txt
python main.py
[
  {"inputs":[],"stateMutability":"nonpayable","type":"constructor"},
  {"inputs":[],"name":"MAX_SUPPLY","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},
  {"inputs":[{"internalType":"string","name":"action","type":"string"},{"internalType":"address","name":"target","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"performAction","outputs":[],"stateMutability":"nonpayable","type":"function"},
  {"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},
  {"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},
  {"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},
  {"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},
  {"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},
  {"inputs":[{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"}
]

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
git init
git add .
git commit -m "Initial Chinparu Agent setup"
git branch -M main
git remote add origin https://github.com/DEIN_USERNAME/chinparu-agent.git
git push -u origin main
https://github.com/MarcMaverick/chinparu-agent
