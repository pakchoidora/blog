<script type="text/javascript">
  function hasMobileUA () {
    return /iPad|iPhone|Android|Opera Mini|BlackBerry|webOS|UCWEB|Blazer|PSP|IEMobile|Symbian/g.test(window.navigator.userAgent);
  }
  function isDesktop () { return screen.width > 991 && !hasMobileUA(); }
  function isTablet () { return screen.width < 992 && screen.width > 767 && hasMobileUA(); }
  function isMobile () { return screen.width < 767 && hasMobileUA(); }
  function escapeSelector (selector) { return selector.replace(/[!"$%&'()*+,.\/:;<=>?@[\\\]^`{|}~]/g, "\\$&") }
</script>