{% if theme.baidu_analytics %}
<script type="text/javascript">
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "//hm.baidu.com/hm.js?{{ theme.baidu_analytics }}";
    var s = document.getElementsByTagName("script")[0];
    if (!(/^localhost|^(\d+\.){3}\d+/.test(window.location.hostname))) s.parentNode.insertBefore(hm, s);
  })();
</script>
{% endif %}