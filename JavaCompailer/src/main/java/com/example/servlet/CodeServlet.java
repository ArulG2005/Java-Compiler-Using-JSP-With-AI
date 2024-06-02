package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@WebServlet("/execute")
public class CodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        // Check if the provided code contains a main method
        if (!containsMainMethod(code)) {
            // If the code does not contain a main method, return an error
            request.setAttribute("output", "Error: Main method not found in the provided code.");
            request.getRequestDispatcher("result.jsp").forward(request, response);
            return;
        }

        // Save code to a temporary file
        File sourceFile = new File(System.getProperty("java.io.tmpdir"), "TempCode.java");
        try (PrintWriter out = new PrintWriter(sourceFile)) {
            out.println(code);
        }

        // Compile and execute the code
        String executionResult;
        try {
            executionResult = executeCode(sourceFile);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            executionResult = "Error during code execution: " + e.getMessage();
        }

        // Forward the output to the result JSP
        request.setAttribute("output", executionResult);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    private boolean containsMainMethod(String code) {
        return code.contains("public static void main(String[] args)");
    }

    private String executeCode(File sourceFile) throws IOException, InterruptedException {
        // Compile the code
        ProcessBuilder compiler = new ProcessBuilder("javac", sourceFile.getAbsolutePath());
        Process compileProcess = compiler.start();
        String compileErrors = readStream(compileProcess.getErrorStream());
        compileProcess.waitFor();

        // Execute the compiled code if compilation was successful
        String executionResult;
        if (compileErrors.isEmpty()) {
            ProcessBuilder executor = new ProcessBuilder("java", "-cp", System.getProperty("java.io.tmpdir"), "TempCode");
            Process executeProcess = executor.start();
            executionResult = readStream(executeProcess.getInputStream()) + readStream(executeProcess.getErrorStream());
            executeProcess.waitFor();
        } else {
            executionResult = compileErrors;
        }
        return executionResult;
    }

    private String readStream(InputStream inputStream) throws IOException {
        StringBuilder result = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                result.append(line).append("\n");
            }
        }
        return result.toString();
    }
}
