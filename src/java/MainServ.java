package java;/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author vedhs
 */
public class MainServ extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println(makehtml());
            System.out.println("_______________________");
            if(request.getParameter("ln")!=null||request.getParameter("sn")!=null)
            {             
                if(!request.getParameter("ln").equals(""))
                {
                    if(!request.getParameter("lp").equals(""))
                    {
                        out.print("comes here!");
                        RequestDispatcher tologin=request.getRequestDispatcher("login");                                          
                        tologin.forward(request, response);
                    }
                    else
                    {
                        out.println("Error : Please fill the password field");
                    }
                } 
                if(!request.getParameter("sn").equals(""))
                {
                    if(!request.getParameter("sp").equals(""))
                    {                                                
                        RequestDispatcher tosignup=request.getRequestDispatcher("signup");
                        request.setAttribute("uname", request.getParameter("sn"));
                        request.setAttribute("pass", request.getParameter("sp"));
                        request.setAttribute("phno", request.getParameter("sph"));
                        request.setAttribute("address", request.getParameter("sa"));                        
                        tosignup.forward(request, response);
                    }
                    else
                    {
                        out.println("Error : Please fill the password field");
                    }
                }
            }
            else
            {
                out.println("Error : Please enter the username");
            }
        }
    }

    String makehtml()
    {
        return "<!DOCTYPE html>\n" +
                "<!--\n" +
                "To change this license header, choose License Headers in Project Properties.\n" +
                "To change this template file, choose Tools | Templates\n" +
                "and open the template in the editor.\n" +
                "-->\n" +
                "<html>\n" +
                "    <head>\n" +
                "        <title>Login OR Signup</title>\n" +
                "        <meta charset=\"UTF-8\">\n" +
                "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "        <style>\n" +
                "            div.table{\n" +
                "                display : table;\n" +
                "                margin: auto;\n" +
                "                padding: 5px;\n" +
                "                width : auto;\n" +
                "                text-align: center;\n" +
                "                background-color: rgb(245,245,245);\n" +
                "            }\n" +
                "            div.tablem{\n" +
                "                display : table;\n" +
                "                margin: auto;\n" +
                "                padding: 5px;\n" +
                "                width : auto;\n" +
                "                text-align: center;\n" +
                "                background-color: rgb(245,245,245);\n" +
                "                border-radius: 10px;\n" +
                "            }\n" +
                "            div.row{\n" +
                "                display:table-row;\n" +
                "                margin: 5px;\n" +
                "                text-align: center;\n" +
                "                vertical-align: central;\n" +
                "            }\n" +
                "            div.cell{\n" +
                "                display:table-cell;                \n" +
                "                padding: 3px;\n" +
                "                vertical-align: central;\n" +
                "            }\n" +
                "            input.field{\n" +
                "                border-radius: 7px;\n" +
                "            }\n" +
                "            body{\n" +
                "                background-color: rgb(235,235,235);\n" +
                "                background-image: url('loginbgimg.png');\n" +
                "            }\n" +
                "        </style>            \n" +
                "    </head>\n" +
                "    <body>\n" +
                "        <div>\n" +
                "            <form method='get' action='MainServ'>\n" +
                "                <div class=\"tablem\">\n" +
                "                    <div class=\"row\">\n" +
                "                        <div class=\"cell\">\n" +
                "                            <div class='table'>\n" +
                "                                <h3>Login :</h3>\n" +
                "                                <div class='row'>                    \n" +
                "                                    <div class='cell'><img src=\"usernameimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input name='ln' class=\"field\" placeholder=\" Username\"></div>                            \n" +
                "                                </div>\n" +
                "                                <div class=\"row\">\n" +
                "                                    <div class='cell'><img src=\"passwordimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input type=\"password\" name=\"lp\" class=\"field\" placeholder=\" Password\"></div>\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                        <div class=\"cell\">\n" +
                "                            <b><h2>OR</h2></b>\n" +
                "                        </div>\n" +
                "                        <div class=\"cell\">\n" +
                "                            <div class='table'>\n" +
                "                                <h3>SignUp :</h3>\n" +
                "                                <div class='row'>                    \n" +
                "                                    <div class='cell'><img src=\"usernameimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input name='sn' class=\"field\" placeholder=\" Username\"></div>                            \n" +
                "                                </div>\n" +
                "                                <div class='row'>\n" +
                "                                    <div class='cell'><img src=\"passwordimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input type=\"password\" name=\"sp\" class=\"field\" placeholder=\" Password\"></div>\n" +
                "                                </div>\n" +
                "                                <div class='row'>\n" +
                "                                    <div class='cell'><img src=\"phoneimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input type=\"text\" name=\"sph\" class=\"field\" placeholder=\" Phone number\"></div>\n" +
                "                                </div>\n" +
                "                                <div class='row'>\n" +
                "                                    <div class='cell'><img src=\"addressimg.png\" height=\"15\"></div>\n" +
                "                                    <div class=\"cell\"><input type=\"text\" name=\"sa\" class=\"field\" placeholder=\" Address\"></div>\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                    </div>\n" +
                "                    <div class=\"row\">\n" +
                "                        <div class=\"cell\"></div>\n" +
                "                        <div class=\"cell\">\n" +
                "                            <input type='submit' name='submit' value=\"Submit\" class=\"field\">\n" +
                "                        </div>\n" +
                "                        <div class=\"cell\"></div>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </form>\n" +
                "        </div>\n" +
                "    </body>\n" +
                "</html>\n" +
                "";
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
