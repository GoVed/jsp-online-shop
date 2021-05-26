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
            if(request.getParameter("add")!=null)
            {
                int successcart=0;
                String cartp="";
                ResultSet cart = stm.executeQuery("select * from fjdatauserpass where username='"+name+"'");
                while(cart.next())
                {
                    cartp=cart.getString("cart");
                }
                if(cartp!=null)
                {
                    successcart=stm.executeUpdate("update fjdatauserpass set cart='"+cartp+request.getParameter("add")+",' where username='"+name+"'");
                }
                else
                {
                    successcart=stm.executeUpdate("update fjdatauserpass set cart='"+request.getParameter("add")+",' where username='"+name+"'");
                }
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
            #search,#searchtext{
                vertical-align: super;
            }
            @keyframes opac{from{opacity:0} to{opacity:1}}
        </style>  
        <script>
            function addproduct()
            {
                var npid = document.getElementById("newid").value;
                var npname = document.getElementById("newname").value;
                var ncid = document.getElementById("newcid").value;
                var nprice = document.getElementById("newprice").value;
                var nsize = document.getElementById("newsize").value;
                var ncname = document.getElementById("newcname").value;
                var out = "<a href='homepage.jsp?ln=";
                
                if(npid.length>0&&npname.length>0&&ncid.length>0&&nprice.length>0&&nsize.length>0)
                {                                                    
                    out = out + "<%=name%>"+"&npid="+npid+"&npname="+npname+"&ncid="+ncid+"&nprice="+nprice+"&nsize="+nsize;
                    if(ncname.length>0)
                    {
                        out = out + "&ncname=" + ncname;
                    }
                    out=out+"'>add/update?</a>";
                    document.getElementById("status").innerHTML = out;
                    
                }
                else
                {
                    if(npid.length>0)
                    {
                        out = out + "<%=name%>"+"&npid="+npid+"'>delete?</a>"; 
                        document.getElementById("status").innerHTML = out;
                    }
                    else
                    {
                    document.getElementById("status").innerHTML = 'Status : Enter the values !';
                    }
                }
            }
            function addc(id)
            {               
                var minp=document.getElementById("pmin").value;
                var maxp=document.getElementById("pmax").value;
                
                var outlink="homepage.jsp?ln=<%=name%>&";
                <%if(request.getParameter("cat")!=null)
                { String cat="";
                  cat = request.getParameter("cat");
                %>
                        outlink=outlink+"cat=<%=cat%>&";
                <%}%>
                outlink=outlink+"min="+minp+"&";
                outlink=outlink+"max="+maxp+"&";
                outlink=outlink+"add="+id;
                window.location = outlink;
            }
            function setp()
            {               
                var minp=document.getElementById("pmin").value;
                var maxp=document.getElementById("pmax").value;
                var outlink="homepage.jsp?ln=<%=name%>&";
                <%if(request.getParameter("cat")!=null)
                { String cat="";
                  cat = request.getParameter("cat");
                %>
                        outlink=outlink+"cat=<%=cat%>&";
                <%}%>
                outlink=outlink+"min="+minp+"&";
                outlink=outlink+"max="+maxp;
                window.location = outlink;
            }
            function searchp()
            {
                var search=document.getElementById("searchtext").value;
                if(search.length>0)
                {
                    var outlink="homepage.jsp?ln=<%=name%>&";
                    <%if(request.getParameter("cat")!=null)
                    { String cat="";
                      cat = request.getParameter("cat");
                    %>
                            outlink=outlink+"cat=<%=cat%>&";
                    <%}%>
                    outlink = outlink + "min=<%=min%>&max=<%=max%>&search="+search;     
                    window.location = outlink;
                }
            }
        </script>
    </head>
    <body>
        
        <div class='tablem'>
            <div class='row'>
                <div class='cell'>Online store</div>
                <div class='table'>
                    <div class="row">
                        <div class='cell'></div>
                        <div class="cellcat"><img src="searchimg.png" height="25" align="right" id="search"></div>
                        <%if(search!=null)
                        {%>                        
                        <div class='cellcat'><input id='searchtext' size="100" placeholder='Search for products' value='<%=search%>'></insert></div>
                        <%}else{%>
                        <div class='cellcat'><input id='searchtext' size="100" placeholder='Search for products'></insert></div>
                        <%}%>
                        <div class='cellcat'><button onclick="searchp()" id="search">Search</button></div>
                        <div class='cell'></div>
                    </div>
                </div>
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
                    <h3><b>Categories</b></h3>
                    <% 
                        ResultSet rs=stm.executeQuery("select cname from category");                        
                        while(rs.next())
                        {
                            out.println("<a href='homepage.jsp?ln="+name+"&cat="+rs.getString("cname")+"&min="+min+"&max="+max+"'><button name='"+rs.getString("cname")+"'>"+rs.getString("cname")+"</button></a><br>");
                        }
                    %>
                    <hr width="90%">
                    <b>Price range</b>
                    <div class='table'>
                        <div class="row">
                            <div class='cell'>Minimum:</div>
                            <div class="cell"><input id='pmin' value="<%=min%>"></div>
                        </div>
                        <div class="row">
                            <div class="cell">Maximum:</div>                            
                            <div class="cell"><input id='pmax' value="<%=max%>"></div>
                        </div>
                        <div class="row">
                            <div class="cell">
                                <button onclick="setp()">Set Price</button>
                            </div>
                        </div>
                    </div>
                    <% 
                        if(name.equals("ved"))
                        {
                    %>
                    <br><br>
                    <div class='table'>
                        Welcome ADMIN !<br>
                        Enter new product<br>

                            <div class='row'>
                                <div class="cell">Product ID:</div>
                                <div class='cell'><input name='newid' id='newid'></div>
                            </div>
                            <div class='row'>
                                <div class='cell'>Product name:</div>
                                <div class="cell"><input name='newname' id='newname'></div>
                            </div>
                            <div class='row'>
                                <div class='cell'>Product cat ID:</div>
                                <div class="cell"><input name='newcid' id='newcid'></div>
                            </div>
                            <div class='row'>
                                <div class='cell'>Product price:</div>
                                <div class="cell"><input name='newprice' id='newprice'></div>
                            </div>
                            <div class='row'>
                                <div class='cell'>Product size:</div>
                                <div class="cell"><input name='newsize' id='newsize'></div>
                            </div>
                            <div class='row'>
                                <div class='cell'>Cat name(optional):</div>
                                <div class="cell"><input name='newcname' id='newcname'></div>
                            </div>
                        <button onclick='addproduct()'>Submit</button>
                        <p id='status'>
                            <%
                                if(sc>0)
                                {
                            %>
                            Status : success
                            <%
                                }
                                else
                                {
                            %>
                            Status : Press Submit
                            <%}%>
                        </p>
                    </div>
                    <%
                        }            
                    %>                
                </div>
                <div class='cellpro'>
                    <div class='table'>
                        <div class='row'>
                            <div class='cellid'><b>Product ID</b></div>
                            <div class='cell'><b>Product name</b></div>
                            <div class='cell'><b>Size</b></div>
                            <div class='cell'><b>Price</b></div>
                            <div class="cell"><b>Add to cart</b></div>                          
                            
                        </div>
                        <%
                            
                            ResultSet rsp=stm.executeQuery("select pname,pid,price,size from product where price>="+min+" and price<="+max+" and pname like '%"+search+"%'");      
                            if(request.getParameter("cat")!=null)
                            {
                                catsel=1;
                                ResultSet catget=stm.executeQuery("select * from category");
                                while(catget.next())
                                {
                                    if(catget.getString("cname").equals(request.getParameter("cat")))
                                        catsel=catget.getInt("cid");
                                }                                
                                rsp=stm.executeQuery("select pname,pid,price,size from product where cid="+catsel+" and price>="+min+" and price<="+max+" and pname like '%"+search+"%'");                                
                            }
                            while(rsp.next())
                            {
                        %>
                        <div class='row'>
                            <div class='cell'>
                                <%
                                    out.println(rsp.getString("pid")+"<br>");                                    
                                %>
                            </div>
                            <div class='cell'>
                                <%
                                    out.println(rsp.getString("pname")+"<br>");                                    
                                %>
                            </div>
                            <div class='cell'>
                                <%                                
                                    out.println(rsp.getString("size")+"<br>");                                    
                                %>
                            </div>
                            <div class='cell'>
                                <%                               
                                    out.println(rsp.getString("price")+"<br>");                                                                              
                                %>
                            </div>
                            <div class='cellcat'>
                                <%                                   
                                    out.println("<button onclick='addc("+rsp.getString("pid")+")'>Add this item</button>");
                                %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>