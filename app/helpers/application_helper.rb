# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def set_utf_xml
    headers['Content-Type'] = 'text/xml; charset=UTF-8'
  end
  
  def w3c_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%SZ")
  end
  
  def analytics_tag
    "<script type=\"text/javascript\">
    var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");
    document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));
    </script>
    <script type=\"text/javascript\">
    try {
    var pageTracker = _gat._getTracker(\"UA-3880720-2\");
    pageTracker._trackPageview();
    } catch(err) {}</script>"
  end
end
