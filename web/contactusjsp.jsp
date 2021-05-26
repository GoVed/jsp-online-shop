<%-- 
    Document   : homepage
    Created on : 13 Jul, 2018, 2:46:29 PM
    Author     : vedhs
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
            String name="";
            String min="0";
            String search="";
            int catsel;
            name = request.getParameter("ln").toString();
            Statement stm=null;
            Connection con=null;
            int sc=0;
            int flag=0,flag2=0,max=0,maxp=0;
            
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fj","root","root");
            stm=con.createStatement();
            if(request.getParameter("npid")!=null)
            {
                if(request.getParameter("npname")!=null)
                {                    
                    ResultSet checkup=stm.executeQuery("select pid from product");
                    flag=0;
                    while(checkup.next())
                    {
                        if(checkup.getString("pid").equals(request.getParameter("npid")))
                        {
                            flag=1;
                        }
                    }
                    if(flag==0)
                    {
                        ResultSet checkcat=stm.executeQuery("select cid from category");
                        flag2=0;
                        while(checkcat.next())
                        {
                            if(checkcat.getInt("cid")==Integer.parseInt(request.getParameter("ncid")))
                            {
                                flag2=1;
                            }
                        }
                        if(flag2==1)
                        {
                            sc = stm.executeUpdate("insert into product values('"+request.getParameter("npid")+"','"+request.getParameter("npname")+"','"+request.getParameter("ncid")+"','"+request.getParameter("nprice")+"','"+request.getParameter("nsize")+"')");
                        }
                        else
                        {
                            sc = stm.executeUpdate("insert into category values('"+request.getParameter("ncid")+"','"+request.getParameter("ncname")+"')");
                            sc = stm.executeUpdate("insert into product values('"+request.getParameter("npid")+"','"+request.getParameter("npname")+"','"+request.getParameter("ncid")+"','"+request.getParameter("nprice")+"','"+request.getParameter("nsize")+"')");
                        }
                    }
                    else
                    {
                        sc = stm.executeUpdate("update product set pname='"+request.getParameter("npname")+"',cid='"+request.getParameter("ncid")+"',price='"+request.getParameter("nprice")+"',size='"+request.getParameter("nsize")+"' where pid='"+request.getParameter("npid")+"'");
                    }
                }
                else
                {
                    sc = stm.executeUpdate("delete from product where pid="+request.getParameter("npid"));
                }
            }
            ResultSet getmax = stm.executeQuery("select price from product");                                
            while(getmax.next())
            {
                if(max==0)
                    max=getmax.getInt("price");
                if(getmax.getInt("price")>max)
                    max=getmax.getInt("price");
            }
            maxp=max;
            if(request.getParameter("max")!=null)
            {
                max=Integer.parseInt(request.getParameter("max"));
            } 
            
            
            if(request.getParameter("min")!=null)
            {
                min=request.getParameter("min");
            }
            
            if(request.getParameter("search")!=null)
            {
                search=request.getParameter("search");
            }
        %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            div.heading
            {               
                width:100%;
                text-align: center;
                font-size: 25px;
            }
            div.table{
                display : table;
                margin: 0px;                
                width : 100%;
                text-align: center;
                background-color: rgba(245,245,245,0.15);
            }  
            div.tablem{
                display : table;
                margin: 0px;                
                width : 100%;
                text-align: center;
                background-color: rgba(245,245,245,0.5);
            } 
            div.row{
                display:table-row;
                margin: 5px;
                text-align: center;
            }           
            div.cell{
                display:table-cell;                
                padding: 3px;
                width:auto;
            }
            div.cellb{
                display:table-cell;
                padding: 0px;                
            }
            div.cellin
            {
                display:table-cell;
                padding: 0px;
                width:100%;
            }
            div.cellcat{
                display:table-cell;
                padding: 1px;
                width : 10%;
            }
            div.cellpro{
                display:table-cell;
                padding: 1px;
                width : 80%;
            }
            div.cellid{
                display:table-cell;
                padding: 3px;
                width:10px;
            }
            button{
                width:100%;
                max-width:200px;
                height:100%;
                border-radius: 10px;
                margin:2px;
            }
            body{
                background-image:url('bgimg.jpg');
                animation:opac 1s
            }
            input{
                border-radius:7px;
            }
            input#id
            {
                width:100%;
            }
            @keyframes opac{from{opacity:0} to{opacity:1}}
        </style>          
    </head>
    <body>
        
        <div class='tablem'>
            <div class='row'>
                <div class='cell'>Online store</div>
                
            </div>
            <div class='row'>
                <div class='cell'>Hello, <%=name%></div>
                <div class='table'>
                    <div class='row'>                        
                            <div class='cellb'><a href="homepage.jsp?ln=<%=name%>&min=0&max=<%=maxp%>"><button>Home</button></a></div>
                            <div class='cellb'><a href="contactusjsp.jsp?ln=<%=name%>"><button>Customer service</button></a></div>
                            <div class='cellb'><a href="cart.jsp?ln=<%=name%>"><button>Your cart</button></a></div> 
                            <div class='cellb'><a href="index.html"><button>LOGOUT</button></a></div>
                    </div>
                </div>
            </div>
            <div class='row'>
                <div class='cellcat'>
                    Need help?<br>
                    Contact us !
                </div>
                <div class="cellpro">
                    Call us at : 079 - 1234 5678
                    <br>
                    <br>
                    Email us ? <a href="mailto:vedhsuthar@gmail.com?Subject=Customer%20service" target="_top">Send Mail</a>
                </div>
            </div>
        </div>
    </body>
</html>
