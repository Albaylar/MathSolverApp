<div align="center">

# 📐 MathSolver

### Snap a photo. Get the solution. Powered by OCR + AI.

An iOS app that solves math problems from a photo — it recognizes equations on-device, sends them to an LLM for solving, and renders clean, readable results with MathJax.

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

</div>

---

## ✨ Overview

**MathSolver** combines image processing and AI to turn a photograph of a math problem into a step-by-step solution. Point your camera at an equation, crop it, and let the app handle recognition, solving, and clean mathematical typesetting.

## 🚀 Features

- 📸 **Solve from photos** — capture a problem with your camera or pick one from your photo library.
- ✂️ **Smart cropping** — fine-tune the captured region with custom cropping tools (TCROP).
- 🔤 **Equation recognition** — converts handwritten/printed math into **LaTeX** via the MathPix API.
- 🧠 **AI-powered solving** — sends recognized equations to the OpenAI API for understanding and solving.
- 📊 **Clean rendering** — displays solutions beautifully in a WebView using **MathJax**.
- 🕑 **History** — every query and solution is saved locally with **CoreData**.
- 💳 **In-app purchases** — subscriptions managed through **Adapty**.

## 🛠️ Tech Stack

| Area | Technology |
|------|-----------|
| Language | Swift |
| UI | Programmatic UIKit |
| OCR / Math recognition | MathPix API |
| AI solving | OpenAI API |
| Image cropping | TCROP |
| Math rendering | MathJax (WebView) |
| Persistence | CoreData |
| Networking | Alamofire |
| In-app purchases | Adapty |
| API testing | Postman |

## 📲 How It Works

```
 ┌──────────┐    ┌───────────┐    ┌──────────────┐    ┌─────────────┐    ┌──────────────┐
 │  Capture │ →  │   Crop    │ →  │   MathPix    │ →  │   OpenAI    │ →  │   MathJax    │
 │  photo   │    │  region   │    │  → LaTeX     │    │  → solution │    │  → rendered  │
 └──────────┘    └───────────┘    └──────────────┘    └─────────────┘    └──────────────┘
                                                                          (saved to CoreData)
```

## ⚙️ Getting Started

### Prerequisites
- Xcode 14+
- iOS 15+ deployment target
- API keys for **MathPix** and **OpenAI**

### Installation

```bash
git clone https://github.com/Albaylar/MathSolverApp.git
cd MathSolverApp
open MathSolver/MathSolver.xcodeproj
```

### Configuration
Add your API keys before building (e.g. in a `Secrets.swift` file or your configuration of choice):

```swift
enum Secrets {
    static let mathpixAppID  = "YOUR_MATHPIX_APP_ID"
    static let mathpixAppKey = "YOUR_MATHPIX_APP_KEY"
    static let openAIKey     = "YOUR_OPENAI_API_KEY"
}
```

> ⚠️ Never commit real API keys. Add your secrets file to `.gitignore`.

## 🎥 Demo

A demo video is available in the repository. *(Tip: add a GIF or screenshots here for quick previews.)*

## 🗺️ Roadmap

- [ ] Migrate UI to SwiftUI
- [ ] Add step-by-step solution explanations
- [ ] Support multiple languages in the UI
- [ ] Offline solving for basic arithmetic

## 🤝 Contributing

Contributions, issues, and feature requests are welcome. Feel free to open an [issue](https://github.com/Albaylar/MathSolverApp/issues).

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

## 📬 Contact

**Furkan Deniz Albaylar** — iOS Engineer
📧 furkandenizalbaylar@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/furkandenizalbaylar/) · [GitHub](https://github.com/Albaylar)

---

<div align="center">
<sub>Built with ❤️ in Swift</sub>
</div>


# Video


https://github.com/Albaylar/MathSolverApp/assets/67964948/fc52f234-ce84-48b3-8548-a58ea89d3304

