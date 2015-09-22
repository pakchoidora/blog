<!DOCTYPE html>
<html class="theme-ninja use-motion{% if theme.scheme %} theme-ninja-{{ theme.scheme | lower }}{% endif %}">
<head>{% include '_partials/head.swig' %}
<title>{% block title %}{% endblock %}</title>
</head>
<body>
  <div class="container one-column {% block page_class %}{% endblock %}">
  <div class="headband"></div>
  <div id="header" class="header">
    <div class="header-inner">
      {% include '_partials/header.swig' %}
    </div>
  </div>
  <div id="main" class="main">
    <div class="main-inner">
      <div id="content" class="content">{% block content %}{% endblock %}
      </div>
    </div>
    {% block sidebar %}{% endblock %}
  </div>
  <div id="footer" class="footer">
    <div class="footer-inner">
      {% include '_partials/footer.swig' %}
    </div>
  </div>
  <div class="back-to-top"></div>
</div>
<script type="text/javascript" src="{{ url_for(theme.vendors) }}/zepto/zepto.min.js?v=1.1.6"></script>
{% block script_extra_before %}{% endblock %}  {# This block is used to set options before any other scripts run #}
{% include '_scripts/helpers.swig' %}
{% include '_scripts/motion.swig' %}
{% block script_extra %}{% endblock %}
{% include '_scripts/mathjax.swig' %}
{% block comment_system %}{% endblock %}
{% include '_scripts/analytics/google-analytics.swig' %}
</body>
</html>