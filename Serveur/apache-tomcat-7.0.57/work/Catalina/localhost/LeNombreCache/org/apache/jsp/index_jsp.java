/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-02-09 16:10:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import NombreInconnu.NombreInconnu;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Jeux : Nombre Cache</title>\n");
      out.write("        \n");
      out.write("        <link href=\"WEB-INF/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\" type=\"text/css\"/>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("         <div class=\"row\">\n");
      out.write("            <div class=\"col-md-6\">\n");
      out.write("                <div class=\"col-md-4\">Article</div>\n");
      out.write("                <div class=\"col-md-2\">Sidebar</div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <h1>Jeux : Nombre Cache</h1>\n");
      out.write("        <p> trouvez un nombre caché compris entre 0 et 1000 en 10 coups maximun </p>\n");
      out.write("        <p> il vous reste : ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${nbInconnu.nbEssaisRestant}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</p>\n");
      out.write("        <p> ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${rep}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(" </p>\n");
      out.write("        \n");
      out.write("        \n");
      out.write("        <form action=\"JeuxServlets\">\n");
      out.write("            ");
 
                String bout = "Rejouer";
                NombreInconnu nbInconnu = (NombreInconnu) session.getAttribute("nbInconnu");
                if(nbInconnu.getNbEssaisRestant() >0 ){
                    bout = "Abandonner";
                    
      out.write("\n");
      out.write("                    Votre Proposition : \n");
      out.write("                     <input type=\"number\" name=\"proposition\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${param.proposition}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\" size=\"4\"  min=\"0\" max=\"1000\"> </br>\n");
      out.write("                    <input type=\"submit\" value=\"Valider\" style=\"display: inline\">\n");
      out.write("                ");
}
      out.write("\n");
      out.write("                \n");
      out.write("        </form>\n");
      out.write("       <input type =\"button\" value=\"");
      out.print(bout);
      out.write("\" onclick=\"index.html\">\n");
      out.write("       <!-- <form action=\"DeconnectServlets\">\n");
      out.write("            <input type=\"submit\" value=\"Deconnection\">\n");
      out.write("        </form>\n");
      out.write("        --> \n");
      out.write("    </body>\n");
      out.write("    <footer>\n");
      out.write("        <script src=\"http://code.jquery.com/jquery.js\"></script>\n");
      out.write("        <script src=\"WEB-INF/bootstrap/js/bootstrap.min.js\" type=\"text/javascript\"></script>\n");
      out.write("    </footer>\n");
      out.write("</html>\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
