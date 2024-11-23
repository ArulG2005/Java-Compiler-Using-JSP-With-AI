# Java-Compiler-Using-JSP-With-AI

This is a simple web application that allows users to compile and run Java code through a web interface. The application uses JSP (JavaServer Pages) to handle the compilation and execution of the Java code. Additionally, it includes support for Gemini AI for code assistance and error clarification.

## Features

- Accepts Java source code from a web form.
- Compiles the Java source code on the server.
- Executes the compiled Java program.
- Displays compilation errors and program output to the user.
- Supports Gemini AI for code assistance and error clarification.
- Differentiates compilation errors with color coding for better readability.

## Prerequisites

- Java Development Kit (JDK) installed on the server.
- Apache Tomcat or any other servlet container to run JSP.
- Basic understanding of JSP and Java.
- Gemini AI account for support and API integration.

## Installation

1. **Clone the repository**

    ```sh
    git clone https://github.com/ArulG2005/java-compiler-Using-JSP-With-AI.git
    cd java-compiler-webapp
    ```

2. **Set up your servlet container**

    - Copy the project files to the `webapps` directory of your Apache Tomcat server (or any other servlet container you are using).

3. **Start your servlet container**

    - If using Apache Tomcat, navigate to the `bin` directory and start the server:

    ```sh
    cd /path/to/tomcat/bin
    ./startup.sh
    ```

4. **Access the application**

    - Open your web browser and navigate to `http://localhost:8080/java-compiler-webapp/index.jsp`.

## Usage

1. **Navigate to the Application**

    Open your web browser and go to `http://localhost:8080/java-compiler-webapp/index.jsp`.

2. **Enter your Java Code**

    - Paste your Java code into the provided text area. For example:

    ```java
    public class Main {
        public static void main(String[] args) {
            System.out.println("Haii, I am Arul");
        }
    }
    ```

3. **Compile and Run**

    - Click the "Compile and Run" button. The application will compile and execute the code.
    - The compilation result, including any errors or program output, will be displayed on the result page.

## Project Structure

java-compiler-webapp/
│
├── index.jsp             # The main page where users can enter their Java code
├── compile.jsp           # The JSP page that handles compilation and execution
├── result.jsp            # The JSP page that displays the result of the compilation and execution
├── WEB-INF/
│   └── web.xml           # Web application configuration file
└── lib/
    └── gemini-ai.jar     # Gemini AI support library for code assistance and error clarification


## Gemini AI Integration

1. **Set up Gemini AI**

    - Sign up for a Gemini AI account and obtain your API key.
    - Include the `gemini-ai.jar` library in the `lib` directory of your project.
    - Use the Gemini AI API for code assistance and error clarification in your JSP pages.

## Important Notes

- Ensure that your server is running a JDK and not just a JRE, as the JRE does not include the necessary tools for compilation.
- Be cautious when executing user-submitted code on your server. In a production environment, you should add proper security measures to prevent malicious code execution.

## Troubleshooting

- **Compilation Not Working:** Make sure your server has the JDK installed and is using it. Verify by running `java -version` and `javac -version`.
- **Server Errors:** Check the server logs for any errors that might indicate what went wrong. Common issues could be file permissions, classpath issues, or missing dependencies.
- **Gemini AI Integration:** Ensure you have the correct API key and the `gemini-ai.jar` library is included in your project.

## Demo Video

Watch the demo video to see the application in action:


https://github.com/ArulG2005/Java-Compiler-Using-JSP-With-AI/assets/146732682/529436fd-d0f0-4404-9e57-511826dce4ab


## Contributing

If you find any issues or have suggestions for improvements, feel free to create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.




