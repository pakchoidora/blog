<h1 class="site-meta">
  <span class="logo-line-before"><i></i></span>
  <a href="{{ config.root }}" class="brand">
    <span class="logo">
      <i class="icon-logo"></i>
    </span>
    <span class="site-title">{{ config.title }}</span>
  </a>
  <span class="logo-line-after"><i></i></span>
</h1>
{% if theme.menu %}
<ul id="menu" class="menu">
  {% if config.swiftype_key %}<form class="menu-item menu-item-{{ itemName }}"><input type="text" id="st-search-input" class="st-search-input" style="width:80px;"/></form>{% set swiftype_key = config.swiftype_key %}
  <script type="text/javascript">
  (function(w,d,t,u,n,s,e){w['SwiftypeObject']=n;w[n]=w[n]||function(){
  (w[n].q=w[n].q||[]).push(arguments);};s=d.createElement(t);
  e=d.getElementsByTagName(t)[0];s.async=1;s.src=u;e.parentNode.insertBefore(s,e);
  })(window,document,'script','//s.swiftypecdn.com/install/v1/st.js','_st');
  _st('install','{{swiftype_key}}');
  </script>{% elseif config.tinysou_Key %}{% set engineKey = config.tinysou_Key %}<form class="menu-item" ><input type="text" id="ts-search-input" class="menu-search-input"></form>
  <script type="text/javascript">
  var option = {
    engineKey: '{{engineKey}}'
  };
  (function(w,d,t,u,n,s,e){
    s = d.createElement(t);
    s.src = u;
    s.async = 1;
    w[n] = function(r){
      w[n].opts = r;
    };
    e = d.getElementsByTagName(t)[0];
    e.parentNode.insertBefore(s, e);
  })(window,document,'script','//tinysou-cdn.b0.upaiyun.com/ts.js','_ts');
  _ts(option);
  </script>
  {% endif %}
  {% for name, path in theme.menu %}{% set itemName = name.toLowerCase() %}
  <li class="menu-item menu-item-{{ itemName }}">
    <a href="{{ url_for(path) }}">
      <i class="menu-item-icon icon-{{ itemName }}"></i><br/>{{ __('menu.' + itemName) }}
    </a>
  </li>
  {% endfor %}
</ul>
{% endif %}