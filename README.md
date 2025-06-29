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
import os, json, time
import openai
from web3 import Web3
from dotenv import load_dotenv

load_dotenv()

PRIVATE_KEY = os.getenv("PRIVATE_KEY")
RPC_URL = os.getenv("RPC_URL")
CONTRACT_ADDRESS = os.getenv("CONTRACT_ADDRESS")
OWNER_ADDRESS = os.getenv("OWNER_ADDRESS")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

openai.api_key = OPENAI_API_KEY

w3 = Web3(Web3.HTTPProvider(RPC_URL))
with open("abi.json") as f:
    abi = json.load(f)

contract = w3.eth.contract(address=Web3.to_checksum_address(CONTRACT_ADDRESS), abi=abi)

def decide_action():
    total = contract.functions.totalSupply().call()
    supply_CHIT = total / (10**18)

    prompt = (f"Chinparu Token hat aktuell {supply_CHIT:.2f} CHIT im Umlauf. "
              f"Du bist der KI-Agent. Soll regelmäßig (alle 24h) eine Aktion durchgeführt werden? "
              f"Antwort mit JSON: {{\"action\":\"mint|burn|reward\",\"target\":\"0x...\",\"amount\":<int>}} oder {{\"action\":\"none\"}}.")

    resp = openai.ChatCompletion.create(model="gpt-4", messages=[{"role":"user","content":prompt}])
    text = resp.choices[0].message.content.strip()
    try:
        data = json.loads(text)
        return data
    except:
        print("GPT-Antwort kein JSON, überspringe Aktion:", text)
        return {"action":"none"}

def send_action(action, target, amount):
    nonce = w3.eth.get_transaction_count(OWNER_ADDRESS)
    txn = contract.functions.performAction(action, Web3.to_checksum_address(target), int(amount)).build_transaction({
        'chainId': 11155111,
        'gas': 200_000,
        'gasPrice': w3.eth.gas_price,
        'nonce': nonce
    })
    signed = w3.eth.account.sign_transaction(txn, PRIVATE_KEY)
    tx_hash = w3.eth.send_raw_transaction(signed.rawTransaction)
    print(f"🛰️ Aktion {action} gesendet: {tx_hash.hex()}")

if __name__ == "__main__":
    while True:
        print("⏱ Entscheide...")
        result = decide_action()
        if result.get("action") != "none":
            print("✅ GPT erlaubt Aktion:", result)
            send_action(result["action"], result["target"], result["amount"])
        else:
            print("⚠️ Keine Aktion ausgeführt.")
        time.sleep(24 * 3600)

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
