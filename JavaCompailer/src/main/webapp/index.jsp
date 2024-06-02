<!DOCTYPE html>
<html>
<head>
    <title>Java Compiler</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/darcula.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2b2b2b;
            color: #f8f8f2;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        h1 {
            color: #66d9ef;
        }
        .CodeMirror {
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
            width: 80%;
            max-width: 900px;
            height: auto;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }
        input[type="submit"] {
            background-color: #66d9ef;
            color: #272822;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #a6e22e;
        }
        /* New CSS for the chat window */
        #chat-window {
            width: 250px;
            height: 400px;
            background-color: #333;
            color: white;
            border-radius: 8px;
            padding: 10px;
            position: fixed;
            top: 350px;
            right: 20px;
            overflow-y: auto;
        }
        #chat-input {
            width: calc(100% - 20px);
            padding: 5px;
            margin-top: 10px;
            border: none;
            border-radius: 4px;
        }
        #chat-input:focus {
            outline: none;
        }
        #chat-button {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            background-color: #66d9ef;
            color: #272822;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        #chat-button:hover {
            background-color: #a6e22e;
        }
    </style>
</head>
<body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/addon/edit/matchbrackets.min.js"></script>

    <h1>Java Compiler</h1>
    <form action="compile.jsp" method="post">
        <textarea id="code" name="code" rows="20" cols="80" placeholder="Enter your Java code here..."></textarea><br>
        <input type="submit" value="Compile">
    </form>

    <!-- Chat Window -->
    <div id="chat-window">
        <h2>Have a question?</h2>
        <input type="text" id="chat-input" placeholder="Type your question...">
        <button id="chat-button">Ask</button>
        <div id="problemai"></div>
    </div>
 <script type="importmap">
        {
          "imports": {
            "@google/generative-ai": "https://esm.run/@google/generative-ai"
          }
        }
      </script>
<script type="module">
    import { GoogleGenerativeAI } from "@google/generative-ai";

    const API_KEY = "AIzaSyAaMJd9QTa4itVw25lc3v9dMpGfnpwq6hc"; 
    const genAI = new GoogleGenerativeAI(API_KEY);

    async function fetchProblem(question) {
        try {
            const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
            const result = await model.generateContent(question);
            const response = await result.response;
            const text = await response.text();
console.log(text);
            document.getElementById('problemai').innerHTML = text;
document.getElementById("chat-input").value = "";
        } catch (error) {
            console.error('Error fetching problem data:', error);
        }
    }

  document.getElementById("chat-button").addEventListener("click", function(event) {
    
    
    var question = document.getElementById("chat-input").value;

    fetchProblem(question);

});
</script>



    <script>
        window.onload = function() {
        	alert("Class Name should be Main");
            var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
                lineNumbers: true,
                mode: "text/x-java",
                matchBrackets: true,
                theme: "darcula"
            });

            document.querySelector("form").addEventListener("submit", function() {
                document.getElementById("code").value = editor.getValue();
               
            });
        };
    </script>
</body>
</html>
