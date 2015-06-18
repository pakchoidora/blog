<script type="text/javascript">
  $(document).ready(function () {
    var body = $('body');
    var isSidebarVisible = false;
    var toggle = $('.sidebar-toggle');
    var line1st = $('.sidebar-toggle-line-first')
    var line2nd = $('.sidebar-toggle-line-middle');
    var line3rd = $('.sidebar-toggle-line-last');
    var sidebar = $('.sidebar');
    var SIDEBAR_WIDTH = '320px';
    var SIDEBAR_DISPLAY_DURATION = 300;
    var statusInit = {width: '100%', opacity: 1, left: 0, rotateZ: 0, top: 0};
    var line1stStatusInit = statusInit;
    var line1stStatusArrow = {width: '50%', rotateZ: '-45deg', top: '2px'};
    var line1stStatusClose = {width: '100%', rotateZ: '-45deg', top: '5px'};
    var line2ndStatusInit = statusInit;
    var line2ndStatusArrow = {width: '90%'};
    var line2ndStatusClose = {opacity: 0};
    var line3rdStatusInit = statusInit;
    var line3rdStatusArrow = {width: '50%', rotateZ: '45deg', top: '-2px'};
    var line3rdStatusClose = {width: '100%', rotateZ: '45deg', top: '-5px'};
    $.Velocity.RunSequence([
      {e: $('.brand'), p: {opacity: 1}, o: {duration: 100}},
      {e: $('.logo'), p: {opacity: 1, top: 0}, o: {duration: 50}},
      {e: $('.site-title'), p: {opacity: 1, top: 0}, o: {duration: 200}}
    ]);
    $('.menu-item').velocity('transition.slideDownIn', {display: null});
    $('.post').velocity('transition.slideDownIn', window.postMotionOptions || {stagger: 300, drag: true});
    $('.back-to-top').on('click', function () {
      body.velocity('scroll');
    });
    function sidebarShowMotion () {
      line1st.velocity(line1stStatusClose);
      line2nd.velocity(line2ndStatusClose);
      line3rd.velocity(line3rdStatusClose);
      sidebar.velocity({width: SIDEBAR_WIDTH}, {
        display: 'block',
        duration: SIDEBAR_DISPLAY_DURATION,
        complete: function () {
          sidebar.addClass('sidebar-active');
          sidebar.trigger('sidebar.didShow');
        }
      });
      setTimeout(function () {
        isDesktop() && body.velocity(
          {paddingRight: SIDEBAR_WIDTH},
          SIDEBAR_DISPLAY_DURATION
        );
        $('.sidebar .motion-element').velocity(
          'transition.slideRightIn',
          {stagger: 50, drag: true}
        );
      }, 0);
    }
    function sidebarHideMotion () {
      isDesktop() && body.velocity({paddingRight: 0});
      sidebar.velocity('reverse');
      line1st.velocity(line1stStatusInit);
      line2nd.velocity(line2ndStatusInit);
      line3rd.velocity(line3rdStatusInit);
      sidebar.removeClass('sidebar-active');
      setTimeout(function() {
        $('.sidebar .motion-element').css({
          display: 'none'
        });
      }, 0);
    };
    toggle.on('click', function () {
      isSidebarVisible ? sidebarHideMotion() : sidebarShowMotion();
      isSidebarVisible = !isSidebarVisible;
    }).on('mouseenter', function () {
      if (isSidebarVisible) {return}
      line1st.velocity('stop').velocity(line1stStatusArrow);
      line2nd.velocity('stop').velocity(line2ndStatusArrow);
      line3rd.velocity('stop').velocity(line3rdStatusArrow);
    }).on('mouseleave', function () {
      if (isSidebarVisible) {return}
      line1st.velocity('stop').velocity(line1stStatusInit);
      line2nd.velocity('stop').velocity(line2ndStatusInit);
      line3rd.velocity('stop').velocity(line3rdStatusInit);
    });
  });
</script>