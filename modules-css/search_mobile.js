/* 
 * Search JS
 */
/* since we're calling a pageview on bi.init, stopping the initial pageview here */
var s_not_pageview = 'y';
var search;
$(document).ready(function () {
  search = webmd.object(webmd.mobile.search).init();
});
webmd.mobile = {};
webmd.mobile.search = {
  count: 10,
  searchResults: null,
  currentPage: 1,
  query: webmd.url.getParam('query').replace(/\+/g, ' '),
  init: function () {
    webmd.debug("test console log");
    var _this = this;
    this.pageContainer = $("#search_results_container");
    $(".search_query").val(this.query)
    if (this.shouldPerformSearch()) {
      this.getSearchResults({
        success: function () {
          _this.displaySearchResults();
        }
      });
    } else {
      this.getDefaultPage();
    }
    return this;
  },
  getCurrentRecord: function () {
    return this.count * (this.currentPage - 1)
  },
  loading: function (isLoading) {
    if (isLoading) {
      $(this.pageContainer).html('<div class="loading" />');
    } else {
      $(this.pageContainer).find(".loading").remove();
    }
  },
  displaySearchResults: function () {
    this.writeSearchResults(this.searchResults);
    this.bi.init(this);
    this.createPaginator();
  },
  createPaginator: function () {
    var _this = this;
    this.paginator = webmd.object(webmd.mobile.pagination, {
      range: 4,
      currentPage: parseFloat(_this.currentPage),
      totalPages: Math.ceil(this.searchResults.cnt / this.count),
      onSelect: function (link) {
        var pageNum = $(link).attr("href");
        wmdSearchTrack("pagenum_" + _this.currentPage);
        _this.currentPage = pageNum
        _this.getSearchResults({
          data: {
            query: _this.query
          },
          success: function () {
            _this.displaySearchResults();
          }
        });
      }
    }).init();
  },
  formatNumber: function (num) {
    num += '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(num)) {
      num = num.replace(rgx, '$1' + ',' + '$2');
    }
    return num;
  },
  shouldPerformSearch: function () {
    //return webmd.url.getParam('query');
    return this.query;
  },
  writeSearchResults: function (data) {
    var _this = this;
    if (data.itms) {
      // private helper to filter out mobile URL if exists

      function filterURL(result) {
        if (result.murl) {
          return result.murl;
        } else {
          return result.url
        }
      }

      function setResultClass(result) {
        if (result.murl) {
          return 'mobile_result'
        } else {
          return 'desktop_result'
        }
      }

      var templates = {
        resultsHeader: '<h3>Results for: {SearchTerm}</h3><div class="results_number top"><strong>{From} - {To} of {Total}</strong> results</div>',
        resultsFooter: '<div class="ftr"><div class="pagination"></div></div>',
        resultsList: '<div class="result"><h4><a class="{Class_Type}" href="{URL}">{Title}<i></i></a></h4><p>{Description}</p><p class="type">{Type}</p></div>',
        healthCenter: '<div class="spotlight toc"><div class="icon hc"> </div><div class="text"><h4><a class="{Class_Type}" href="{URL}">{Title}<i></i></a></h4><p>{Description}</p><p class="type">{Type}</p></div></div>',
        guideZone: '<li class="guide"><a class="{Class_Type}" href="{URL}" >{Title}<i></i></a></li>',
        community: '<div class="spotlight community"><div class="icon comm"> </div><div class="text"><h4><a href="{URL}">{Title}</a></h4><p>{Description}</p><p class="type">{Type}</p></div></div>'
      }
      var pageContent = "";
      pageContent += webmd.substitute(templates.resultsHeader, {
        SearchTerm: _this.query,
        From: this.currentPage * this.count - (this.count - 1),
        To: this.currentPage * this.count,
        Total: this.formatNumber(data.cnt)
      });
      var gz = '',
          toc = '',
          comm = '';
      $(data.supps).each(function () {
        switch (this.nm) {
        case 'Guide Zone':
          $(this.sitms).each(function () {
            gz += webmd.substitute(templates.guideZone, {
              URL: this.url,
              Title: this.ttl,
              // Class_Type: setResultClass(this)
            });
          });
          break;
        case 'PositionZero TOC Zone':
          $(this.sitms).each(function () {
            toc += webmd.substitute(templates.healthCenter, {
              URL: this.url,
              Title: this.ttl,
              Description: this.d,
              Type: this.src,
              // Class_Type: setResultClass(this)
            });
          });
          break;
          //                    case 'PositionZero Community Zone':
          //                        $(this.sitms).each(function(){
          //                            comm += webmd.substitute(templates.community, {
          //                                URL: this.url,
          //                                Title: this.ttl,
          //                                Description: this.d,
          //                                Type: this.src
          //                            });
          //                        });
          //                        break;
        }
      });
      if (this.currentPage == 1) {
        pageContent += toc;
        if (gz != '') {
          pageContent += '<ul class="guide">' + gz + '</ul>';
        }
        pageContent += comm;
      }
      $(data.itms).each(function () {
        pageContent += webmd.substitute(templates.resultsList, {
          URL: filterURL(this),
          Title: this.t,
          Description: (this.d) ? this.d : "",
          Type: this.src,
          Class_Type: setResultClass(this)
        });
      });
      pageContent += webmd.substitute(templates.resultsFooter, {
        From: this.currentPage * this.count - (this.count - 1),
        To: this.currentPage * this.count,
        Total: this.formatNumber(data.cnt)
      });
      $(this.pageContainer).html(pageContent)
    } else {
      var suggestionTemplate = '<h3>Results for: {query}</h3><div class="zero"><strong>0</strong> results</div>' + '{did_you_mean}' + '<div class="sugg"><strong>A few suggestions:</strong><ul><li><span>Make sure all words are spelled correctly</span></li><li>' + '<span>Try different keywords</span></li><li><span>Try more general words</span></li></ul></div>';
      var listItemTemplate = '<li><span><a href="default.htm?query={term}" onclick="wmdSearchTrack(\'dymean_{index}\')">{term}</a> ({cnt} results)</span></li>';
      var suggestionList = '';
      if (typeof this.searchResults.suggs != 'undefined') {
        suggestionTemplate = webmd.substitute(suggestionTemplate, {
          did_you_mean: '<div class="sugg"><strong>Did you mean?</strong><ul>{suggestionList}</ul></div>'
        });
        $.each(this.searchResults.suggs.sugg, function (ndx) {
          suggestionList += webmd.substitute(listItemTemplate, {
            term: this.term,
            cnt: this.cnt,
            index: (ndx + 1)
          });
        });
      } else {
        suggestionTemplate = webmd.substitute(suggestionTemplate, {
          did_you_mean: ''
        });
      }
      $(this.pageContainer).append(webmd.substitute(suggestionTemplate, {
        query: _this.query,
        suggestionList: suggestionList
      }))
    }
    this.loading(false);
  },
  getSearchResults: function (opts) {
    var _this = this;
    var options = $.extend(true, {
      data: {
        site: 'webmd_mobile',
        query: _this.query,
        //string * required
        rtype: webmd.url.getParam('rtype'),
        // integer *required
        cnt: (webmd.url.getParam('cnt')) ? webmd.url.getParam('cnt') : 10,
        //integer
        srt: _this.getCurrentRecord(),
        //integer
        flds: 'pTitle,pDescription,pPubDisplay',
        refs: (webmd.url.getParam('refs')),
        // boolean
        nstate: webmd.url.getParam('nstate'),
        //integer
        supp: true,
        b: 'y'
      },
      success: function () {}
    }, opts);
    // Call Search Service
    this.loading(true);
    $.ajax({
      type: 'GET',
      url: '/search/api/SearchResultsService.svc/getSearchResults',
      data: options.data,
      dataType: 'json',
      success: function (resp) {
        webmd.mobile.search.searchResults = resp;
        options.success(resp);
      },
      error: function () {
        $(this.pageContainer).append('<div class="error">The mobile service is unavailable.  Please use our desktop search.</div>');
      }
    });
  },
  getDefaultPage: function () {
    $.ajax({
      type: 'GET',
      url: '/search/api/PopularSearchTermsService.svc/GetPopularTerms?site=webmd',
      dataType: 'json',
      success: function (data) {
        $('div#search_results_container').append('<div class="top12_container"><h2>Top 12 Searches</h2><div class="top12">' + '<p>Looking for something?  Type what you are searching for in the field above or try one of our top 12 searches.</p>' + '<ol class="terms"></ol><div class="clear"></div></div><div class="top12_btm"></div></div>');
        $(data.terms).each(function () {
          $('ol.terms').append('<li><a href="search.html?query=' + this.nm + '">' + this.nm + '</a></li>');
        });
      },
      error: function () {
        $('div#search_results_container').append('<div class="error">The mobile service is unavailable.  Please use our desktop search.</div>');
      }
    });
  },
  bi: {
    calls: [{
      "selector": ".result a",
      "string": "srch-results"
    }, {
      "selector": ".spotlight.toc a",
      "string": "srch-pz-tocg_title",
      "noPosition": true
    }, {
      "selector": ".guide a",
      "string": "srch-pz-tocg"
    }, {
      "selector": ".spotlight.community h4 a",
      "string": "srch-pz-comm_title"
    }, ],
    init: function (parent) {
      s_query = s_md.prop10 = parent.query;
      wmdPageview(s_pagename);
      $(this.calls).each(function () {
        var biData = this;
        $(biData.selector).live("click", function (e) {
          var position = (biData.noPosition) ? "" : "_" + ($(biData.selector).index(this) + 1);
          wmdSearchTrack(biData.string + position);
          // when going through all the URLs, if it's mobile leave it alone, otherwise do a confirm overlay
          // putting this in here, as I need to carry through the individual bi Data to the overlay click
          if (this.href.indexOf('www.m.') == -1) {
            var theLink = this.href;
            webmd.overlay.confirm({
              ok: 'View Desktop',
              cancel: 'Stay On Mobile',
              text: 'The content you have selected is only available on the desktop version of WebMD.com <div class="content_icons"><div class="icon_desktop"></div><div class="icon_mobile"></div></div>',
              width: '290px'
            });
            // remove the callback off the overlay and override the OK button to go the link as this is easier and works across all devices. The closing callback sometimes doesn't fire cleanly on some mobile devices
            $('#webmd_confirm_true_button').die();
            $('#webmd_confirm_true_button').live('click', function () {
              wmdSearchTrack(biData.string + position);
              window.location.href = theLink;
              return false;
            });
            // overriding the default close button as well to include custom omniture
            $('#webmd_confirm_false_button').die();
            $('#webmd_confirm_false_button').live('click', function () {
              webmd.overlay.close();
              wmdPageLink('srch-desktop-cancel');
            });
            return false;
          }
        })
      })
    }
  }
}
webmd.mobile.pagination = {
  range: 5,
  test: {
    mykey: "myValue"
  },
  paginator: null,
  totalPages: null,
  currentPage: null,
  onSelection: function () {},
  init: function () {
    var _this = this;
    this.create();
    $(".pagination").append(this.paginator)
    this.paginator.find("li").click(function (e) {
      e.preventDefault();
      if (!$(this).hasClass('current')) {
        _this.onSelect($(this).find("a"))
      }
    })
  },
  create: function () {
    var container = $('<ul class="paginator">');
    var arrowTemplate = '<li class="{clazz}"><span class="arrow {state}"><a class="arrow_{direction}" href="{value}"></a></span></li>'
    var offsetPageDisplay = null;
    var i = this.setRangeStartPage();
    var endPage = this.setRangeEndPage(i);
    while (i <= endPage) {
      var pageNumber = $('<li class="page_num"><a href="#"></a></li>');
      if (i == this.setRangeStartPage()) {
        pageNumber.addClass("first");
      }
      if (i == this.currentPage) {
        pageNumber.addClass("current");
      }
      pageNumber.find("a").attr("href", i).html(i);
      container.append(pageNumber);
      i++;
    }
    // Create last page indicator
    if (this.totalPages != endPage) {
      var ellipsis = $('<li class="page_num last"><span>...</span><a href="#"></a></li>');
      ellipsis.find("a").attr("href", this.totalPages).html(this.totalPages);
      container.append(ellipsis);
    }
    // Create Arrow Controls
    if (this.currentPage != 1) {
      container.prepend(webmd.substitute(arrowTemplate, {
        clazz: "previous",
        state: (this.currentPage == 1) ? "off" : "on",
        direction: "left",
        value: this.currentPage - 1
      }));
    }
    if (this.currentPage != this.totalPages) {
      container.append(webmd.substitute(arrowTemplate, {
        clazz: "next",
        state: (this.currentPage == this.totalPages) ? "off" : "on",
        direction: "right",
        value: this.currentPage + 1
      }));
    }
    this.paginator = container;
  },
  setRangeStartPage: function () {
    var startOffset = Math.floor(this.range / 2);
    if ((this.currentPage - startOffset) <= 0) {
      return 1;
    } else if ((this.currentPage + startOffset) >= this.totalPages) {
      return this.totalPages - this.range
    } else {
      return this.currentPage - startOffset;
    }
  },
  setRangeEndPage: function (startPage) {
    if (startPage + this.range > this.totalPages) {
      return this.totalPages;
    } else {
      return startPage + this.range;
    }
  }
}