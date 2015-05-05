{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template %}
{% block title %}{% set page_title_suffix = ' // ' + config.title %}
  {% if page.type === "categories" %}{{ __('title.category') + page_title_suffix }}
  {% elif page.type === "tags" %}{{ __('title.tag') + page_title_suffix }}
  {% else %}{{ page.title + page_title_suffix }}{% endif %}
{% endblock %}
{% block content %}
<div id="posts" class="posts-expand">
  {% if page.type === "tags" %}  {# tagcloud page support #}
  <div class="tag-cloud">
    <div class="tag-cloud-title">
    {{ _p('counter.tag_cloud', site.tags.length) }}
    </div>
    <div class="tag-cloud-tags">
    {{ tagcloud({min_font: 12, max_font: 30, amount: 200, color: true, start_color: '#ccc', end_color: '#111'}) }}
    </div>
  </div>
  {% elif page.type === 'categories' %}
  <div class="category-all-page">
    <div class="category-all-title">
    {{ _p('counter.categories', site.categories.length) }}
    </div>
    <div class="category-all">
    {{ list_categories() }}
    </div>
  </div>
  {% elseif page.status == 404 %}
    {{ page.content }}
  {% else %}
    {{ page.content }}
  {% endif %}
</div>
{% endblock %}
{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}