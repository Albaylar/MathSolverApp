//
//  WebViewHelper.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 11.12.2023.
//

import Foundation
import WebKit
class WebViewHelper {
    // This is a display first Latex Form (Question)
    static func displayLatex(_ latex: String, in webView: WKWebView) {
        let htmlString = """
                <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <script type="text/javascript" async
                        src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
                    </script>
                    <style>
                        p {
                            font-family: Arial, sans-serif;
                            font-size: 18px;
                            text-align: left;
            
                        }
                    </style>
                </head>
                <body>
                    <p>\\[
                        \(latex)
                    \\]</p>
                </body>
                </html>
            """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    // Load Latex Format in Solution
    static func loadLatexContent(_ latexString: String, in webView: WKWebView) {
        let escapedLatexString = latexString.replacingOccurrences(of: "\\", with: "\\\\")
        let htmlString = """
       <html>
       <head>
       <meta name="viewport" content="initial-scale=1.0" />
       <script type="text/javascript" src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
       <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-AMS_HTML"></script>
       <style type="text/css">
       body, html { margin: 0; padding: 0; }
       p {
       font-family: Arial, sans-serif;
       font-size: 20px;
       text-align: left;
       line-height: 0;
         }
       </style>
       <script type="text/javascript">
       document.addEventListener('DOMContentLoaded', function() {
           MathJax.Hub.Queue(function() {
               var height = document.body.scrollHeight;
               window.webkit.messageHandlers.adjustHeight.postMessage(height);
           });
       });
       </script>
       </head>
       <body>
        <p id="math-content">
            <script type="math/tex; mode=display">
             \(escapedLatexString)
            </script>
        </p>
       </body>
       </html>
       """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    // Display for History
    static func loadLatex(_ latex: String, in webView: WKWebView) {
        let htmlContent = """
                <!DOCTYPE html>
                <html>
                <head>
                    <script type="text/javascript" src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
                    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.0/es5/tex-mml-chtml.js" async></script>
                    <style>
                        body {
                            font-size: 500%; /* Adjust the font size as needed */
                            text-align: center; /* Center the text */
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                        }
                        mathjax {
                            line-height: normal;
                        }
                    </style>
                </head>
                <body>
                    <mathjax>\\(\(latex)\\)</mathjax>
                </body>
                </html>
                """
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
}
