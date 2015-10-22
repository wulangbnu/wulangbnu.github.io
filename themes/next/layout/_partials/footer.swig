<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; &nbsp; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
  &nbsp;&nbsp;&nbsp;
</div>
based on <a class="theme-link" href="http://hexo.io">Hexo</a> and  theme by <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next"> NexT </a>.
{% block footer %}{% endblock %}
