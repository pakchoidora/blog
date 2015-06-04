<script type="text/javascript">
  $(document).ready(function () {
    var body = $('body');
    var isSidebarVisible = false;
    var toggle = $('.sidebar-toggle');
    var toggleLine1st = $('.sidebar-toggle-line-first')
    var toggleLine2nd = $('.sidebar-toggle-line-middle');
    var toggleLine3rd = $('.sidebar-toggle-line-last');
    var sidebar = $('.sidebar');
    var SIDEBAR_WIDTH = '320px';
    var SIDEBAR_DISPLAY_DURATION = 300;
    var toggleLineStatusInit = {width: '100%', opacity: 1, left: 0, rotateZ: 0, top: 0};
    var toggleLine1stStatusInit = toggleLineStatusInit;
    var toggleLine1stStatusArrow = {width: '50%', rotateZ: '-45deg', top: '2px'};
    var toggleLine1stStatusClose = {width: '100%', rotateZ: '-45deg', top: '5px'};
    var toggleLine2ndStatusInit = toggleLineStatusInit;
    var toggleLine2ndStatusArrow = {width: '90%'};
    var toggleLine2ndStatusClose = {opacity: 0};
    var toggleLine3rdStatusInit = toggleLineStatusInit;
    var toggleLine3rdStatusArrow = {width: '50%', rotateZ: '45deg', top: '-2px'};
    var toggleLine3rdStatusClose = {width: '100%', rotateZ: '45deg', top: '-5px'};
    LogoAndMenuMotion();
    sidebarToggleMotion();
    postsListMotion();
    backToTopMotion();
    $(document)
      .on('sidebar.isShowing', function () {
        isDesktop() && body.velocity(
          {paddingRight: SIDEBAR_WIDTH},
          SIDEBAR_DISPLAY_DURATION
        );
        sidebarContentMotion();
      })
      .on('sidebar.isHiding', function () {});
    function LogoAndMenuMotion() {
      $.Velocity.RunSequence([
        { e: $('.brand'), p: { opacity: 1 }, o: { duration: 100 } },
        { e: $('.logo'), p: { opacity: 1, top: 0 }, o: { duration: 50} },
        {% if theme.scheme === 'Mist' %}
        { e: $('.logo-line-before i'), p: { translateX: "100%" }, o: { duration: 500, sequenceQueue: false } },
        { e: $('.logo-line-after i'), p: { translateX: "-100%" }, o: { duration: 500, sequenceQueue: false } },
        {% endif %}
        { e: $('.site-title'), p: { opacity: 1, top: 0 }, o: { duration: 200 } }
      ]);
      $('.menu-item').velocity('transition.slideDownIn', {display: null});
    }
    function backToTopMotion () {
      var b2top = $('.back-to-top');
      b2top.on('click', function () {
        body.velocity('scroll');
      });
    }
    function sidebarShowMotion () {
      toggleLine1st.velocity(toggleLine1stStatusClose);
      toggleLine2nd.velocity(toggleLine2ndStatusClose);
      toggleLine3rd.velocity(toggleLine3rdStatusClose);
      sidebar.velocity({width: SIDEBAR_WIDTH}, {
        display: 'block',
        duration: SIDEBAR_DISPLAY_DURATION,
        complete: function () {
          sidebar.addClass('sidebar-active');
          sidebar.trigger('sidebar.didShow');
        }
      });
      sidebar.trigger('sidebar.isShowing');
    }
    function sidebarHideMotion () {
      isDesktop() && body.velocity({paddingRight: 0});
      sidebar.velocity('reverse');
      toggleLine1st.velocity(toggleLine1stStatusInit);
      toggleLine2nd.velocity(toggleLine2ndStatusInit);
      toggleLine3rd.velocity(toggleLine3rdStatusInit);
      sidebar.removeClass('sidebar-active');
      sidebar.trigger('sidebar.isHiding');
    };
    function sidebarContentMotion () {
      $('.sidebar .motion-element').velocity(
        'transition.slideRightIn',
        {stagger: 50, drag: true}
      );
    }
    function postsListMotion () {
      var postMotionOptions = window.postMotionOptions || {stagger: 300, drag: true};
      $('.post').velocity('transition.slideDownIn', postMotionOptions);
    }
    function sidebarToggleMotion () {
      toggle.on('click', function () {
        isSidebarVisible ? sidebarHideMotion() : sidebarShowMotion();
        isSidebarVisible = !isSidebarVisible;
      });
      toggle.hover(function () {
        if (isSidebarVisible) {return}
        toggleLine1st.velocity('stop').velocity(toggleLine1stStatusArrow);
        toggleLine2nd.velocity('stop').velocity(toggleLine2ndStatusArrow);
        toggleLine3rd.velocity('stop').velocity(toggleLine3rdStatusArrow);
      }, function () {
        if (isSidebarVisible) {return}
        toggleLine1st.velocity('stop').velocity(toggleLine1stStatusInit);
        toggleLine2nd.velocity('stop').velocity(toggleLine2ndStatusInit);
        toggleLine3rd.velocity('stop').velocity(toggleLine3rdStatusInit);
      });
    }
  });
</script>