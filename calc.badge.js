// A dynamic action plug-in function can access it's current context with the "this" object.
// It contains for example "action" which stores the dynamic attributes attribute01 - attribute10 and
// the ajaxIdentifier used for the AJAX call. Inside the function you can use
// "this.affectedElements" to get a jQuery object which contains all the affected
// DOM elements our dynamic action should be performed on.
//
// For dynamic action plug-in functions you should use a function name which is
// unique, so it doesn't get in conflict with existing functions. Best practise
// is to use the same name as used for the plug-in internal name.

function user_demovicj_calc_badge() {
  // It's better to have named variables instead of using
  // the generic ones, that makes the code more readable
  var lPageItemsToSubmit = this.action.attribute01;
  // Build an AJAX request as you would do for an on-demand call. The only
  // difference is that instead of "APPLICATION_PROCESS=" you have to use "PLUGIN="
  var lAjaxRequest = new htmldb_Get(null, $v('pFlowId'), "PLUGIN="+this.action.ajaxIdentifier, $v('pFlowStepId'));
  var lAjaxResult  = null;
  // Set session state with the AJAX request for all page items which are defined
  // in our "Page Items to submit" attribute. Again we can use jQuery.each to
  // loop over the array of page items.
  if (lPageItemsToSubmit != '') {
  jQuery.each(
    lPageItemsToSubmit.split(','), // this will create an array
    function() {
      var lPageItem = apex.jQuery('#'+this)[0]; // get the DOM object
      // Only if the page item exists, we add it to the AJAX request
      if (lPageItem) {
        lAjaxRequest.add(this, $v(lPageItem)); }
    });}
  // let's execute the AJAX request
  lAjaxResult = lAjaxRequest.get();
  //parse json object
  obj = JSON.parse(lAjaxResult);
  //calculate variables
  var p  = $(obj.selector);
  var position = p.position();
  var w  = p.width() + obj.l_offset;
  var dv_badge = 'badge-'+obj.badge_id;
  //remove badge created before - refresh 
  $('div#' + dv_badge).remove();
  //add badge div next to jQuery selector selected item
  $(obj.selector).after('<div id="'+dv_badge+'" class="badge" style="left:' + w + 'px;top:' + obj.l_top + 'px;">'+ obj.badge +'</div>');
};
