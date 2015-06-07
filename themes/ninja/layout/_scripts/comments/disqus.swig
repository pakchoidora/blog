{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
  {% if theme.disqus_shortname %}
    {% if page.comments %}
      {% set disqus_scripts = ['count', 'embed'] %}
    {% else %}
      {% set disqus_scripts = ['count'] %}
    {% endif %}
<script type="text/javascript">
  var disqus_shortname = '{{ theme.disqus_shortname }}';
  var disqus_identifier = '{{ page.path }}';
  var disqus_url = '{{ page.permalink }}';
  (function(){
    var scripts = '{{ disqus_scripts }}'.split(',');
    for (var k in scripts) {
      var script = scripts[k];
      var dsq = document.createElement('script');
      dsq.type = 'text/javascript';
      dsq.async = true;
      dsq.src = '//' + disqus_shortname + '.disqus.com/' + script + '.js';
      (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    }
  }());
</script>
  {% endif %}
{% endif %}