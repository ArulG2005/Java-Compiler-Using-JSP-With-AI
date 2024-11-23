<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, javax.tools.*, java.util.*" %>
<%
    String sourceCode = request.getParameter("code");
    String filePath = application.getRealPath("/") + "Main.java";
    StringWriter errorStream = new StringWriter();
    StringWriter outputStream = new StringWriter();
    Process process = null;
    BufferedReader input = null;
    BufferedReader error = null;
    FileWriter writer = null;

    try {
        // Write source code to Main.java
        writer = new FileWriter(filePath);
        writer.write(sourceCode);
        writer.close();

        // Compile Main.java
        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
        if (compiler == null) {
            throw new RuntimeException("Java Compiler not available. Make sure you are running the server with a JDK, not just a JRE.");
        }

        StandardJavaFileManager fileManager = compiler.getStandardFileManager(null, null, null);
        Iterable<? extends JavaFileObject> compilationUnits = fileManager.getJavaFileObjectsFromStrings(Arrays.asList(filePath));
        JavaCompiler.CompilationTask task = compiler.getTask(errorStream, fileManager, null, null, null, compilationUnits);

        boolean success = task.call();
        fileManager.close();
        String errors = errorStream.toString();

        if (success) {
            request.setAttribute("message", "Compilation Successful");

            // Execute the compiled class
            String classPath = application.getRealPath("/");
            process = Runtime.getRuntime().exec("java -cp " + classPath + " Main");
            input = new BufferedReader(new InputStreamReader(process.getInputStream()));
            error = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            String line;
            while ((line = input.readLine()) != null) {
                outputStream.write(line + "\n");
            }
            while ((line = error.readLine()) != null) {
                outputStream.write(line + "\n");
            }

            process.waitFor();
        } else {
            request.setAttribute("message", "Compilation Failed");
        }

        request.setAttribute("errors", errors);
        request.setAttribute("output", outputStream.toString());
    } catch (Exception e) {
        request.setAttribute("message", "Error during execution: " + e.getMessage());
    } finally {
        if (writer != null) try { writer.close(); } catch (IOException ignore) {}
        if (errorStream != null) try { errorStream.close(); } catch (IOException ignore) {}
        if (input != null) try { input.close(); } catch (IOException ignore) {}
        if (error != null) try { error.close(); } catch (IOException ignore) {}
        if (process != null) process.destroy();
    }

    request.getRequestDispatcher("result.jsp").forward(request, response);
%>
