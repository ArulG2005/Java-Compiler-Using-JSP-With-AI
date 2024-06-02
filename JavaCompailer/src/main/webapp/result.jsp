<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compilation Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            padding: 20px;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
            text-align: center;
        }
        .result-container {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .success-icon {
            color: #28a745;
            font-size: 24px;
            margin-right: 10px;
        }
        .error-icon {
            color: #dc3545;
            font-size: 24px;
            margin-right: 10px;
        }
        .message {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .error-container {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
        .output-container {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
        .try-again {
            margin-top: 20px;
            display: inline-block;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #007bff;
            padding: 8px 16px;
            border-radius: 4px;
        }
        .try-again:hover {
            background-color: #007bff;
            color: #fff;
        }
        @media screen and (max-width: 768px) {
            .result-container {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <h1>Compilation Result</h1>
    <div class="result-container">
        <% String message = (String) request.getAttribute("message"); %>
        <% String errors = (String) request.getAttribute("errors"); %>
        <% String output = (String) request.getAttribute("output"); %>

        <% if (message != null && !message.isEmpty()) { %>
            <p class="message">
                <% if ("Compilation Successful".equals(message)) { %>
                    <span class="success-icon">&#10004;</span>
                <% } else { %>
                    <span class="error-icon">&#10006;</span>
                <% } %>
                <%= message %>
            </p>
        <% } %>
        
        <% if (errors != null && !errors.isEmpty()) { %>
            <div class="error-container">
                <h2>Error:</h2>
                <pre><%= errors %></pre>
            </div>
        <% } %>
        
        <% if (output != null && !output.isEmpty()) { %>
            <div class="output-container">
                <h2>Program Output:</h2>
                <pre><%= output %></pre>
            </div>
        <% } %>
    </div>
    <a href="index.jsp" class="try-again">Try Again</a>
</body>
</html>

