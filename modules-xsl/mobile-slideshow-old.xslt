<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Force the output to be strict XHTML -->
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"></xsl:output>
	<xsl:param name="class_id"></xsl:param>
	<xsl:param name="image_server_url">
		<xsl:text>http://img.preview.webmd.com/dtmcms/preview</xsl:text>
	</xsl:param>
	<xsl:param name="moduletitle"></xsl:param>
	<xsl:param name="site_id">3</xsl:param>
	<xsl:param name="domain">webmd.com</xsl:param>
	<xsl:template match="/">
		<xsl:apply-templates select="/webmd_rendition/webmd_rendition/content/wbmd_asset/content_section/cons_slideshow"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="cons_slideshow">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>ss</xsl:text></xsl:attribute>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>ss_head</xsl:text></xsl:attribute>
				<xsl:element name="h2">
					<xsl:value-of select="title" disable-output-escaping="yes"></xsl:value-of>
				</xsl:element>
				<xsl:call-template name="CreateNavDiv"></xsl:call-template>
			</xsl:element>
			
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>preload_spinner</xsl:text></xsl:attribute>
			</xsl:element>
			
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>ss_slides</xsl:text></xsl:attribute>
				<xsl:call-template name="CreateCaptionDivs"></xsl:call-template>
			
			
				<xsl:choose>

				<xsl:when test="//webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/slide_has_redirect_link='true' and //webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/show_interstitial='true'">
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>ss_slide</xsl:text></xsl:attribute>

						<xsl:element name="div">
							<xsl:attribute name="class"><xsl:text>ss_slide_text</xsl:text></xsl:attribute>
								
								<xsl:element name="div">
								<xsl:attribute name="class"><xsl:text>seamless_ss</xsl:text></xsl:attribute>
							
								<xsl:if test="//webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/interstitial_desc != ''">
									<xsl:element name="p">
										<xsl:text>Loading Next Slideshow:</xsl:text>
									</xsl:element>
									<xsl:element name="h3">
										<xsl:value-of select="//webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/interstitial_desc"></xsl:value-of>
									</xsl:element>
								</xsl:if>
								
								<xsl:element name="div">
									<xsl:attribute name="class"><xsl:text>preload_spinner</xsl:text></xsl:attribute>
								</xsl:element>
																
								</xsl:element>
							
						</xsl:element>
						<xsl:element name="div">
							<xsl:attribute name="class"><xsl:text>clearingDiv</xsl:text></xsl:attribute>
							<xsl:text><![CDATA[ ]]></xsl:text>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				

				
				
				<xsl:otherwise>
					<!--- Last Global Slide -->
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>ss_slide</xsl:text></xsl:attribute>
						<xsl:element name="div">
							<xsl:attribute name="class"><xsl:text>ss_slide_text</xsl:text></xsl:attribute>
							<xsl:element name="div">
								<xsl:attribute name="class"><xsl:text>last_slide</xsl:text></xsl:attribute>
								<xsl:element name="h4"><xsl:text>Featured Slideshows</xsl:text></xsl:element>
								<xsl:element name="div">
									<xsl:attribute name="class"><xsl:text>last_slide_tile</xsl:text></xsl:attribute>
									<xsl:element name="div">
										<xsl:attribute name="class"><xsl:text>image</xsl:text></xsl:attribute>
										<xsl:element name="a">
											<xsl:attribute name="onclick"><xsl:text>return sl(this,'','ss-default-tile-1-img');</xsl:text></xsl:attribute>
											<xsl:attribute name="href"><xsl:text>/www/diet/slideshow-no-diet-weight-loss</xsl:text></xsl:attribute>
											<xsl:element name="img">
												<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:text>/webmd/consumer_assets/site_images/thumbnails/health_tools/thumbnail_lose_weight_without_dieting_slideshow.jpg</xsl:text></xsl:attribute>
												<xsl:attribute name="border">0</xsl:attribute>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="div">
										<xsl:attribute name="class"><xsl:text>text</xsl:text></xsl:attribute>
										<xsl:element name="h5"><xsl:text>The No-Diet Diet: 24 Tips</xsl:text></xsl:element>
										<xsl:element name="a">
											<xsl:attribute name="onclick"><xsl:text>return sl(this,'','ss-default-tile-1');</xsl:text></xsl:attribute>
											<xsl:attribute name="href"><xsl:text>/www/diet/slideshow-no-diet-weight-loss</xsl:text></xsl:attribute>
											<xsl:text>How to slim down without starving.</xsl:text>
										</xsl:element>
									</xsl:element>
									<xsl:element name="div">
									<xsl:attribute name="class"><xsl:text>clearing</xsl:text></xsl:attribute>
									</xsl:element>
								</xsl:element>
								<xsl:element name="div">
									<xsl:attribute name="class"><xsl:text>last_slide_tile</xsl:text></xsl:attribute>
									<xsl:element name="div">
										<xsl:attribute name="class"><xsl:text>image</xsl:text></xsl:attribute>
										<xsl:element name="a">
											<xsl:attribute name="onclick"><xsl:text>return sl(this,'','ss-default-tile-2-img');</xsl:text></xsl:attribute>
											<xsl:attribute name="href"><xsl:text>/www/allergies/slideshow-bad-bugs</xsl:text></xsl:attribute>
											<xsl:element name="img">
												<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:text>/webmd/consumer_assets/site_images/thumbnails/health_tools/cdc_thumbnail_of_black_window.jpg</xsl:text></xsl:attribute>
												<xsl:attribute name="border">0</xsl:attribute>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="div">
										<xsl:attribute name="class"><xsl:text>text</xsl:text></xsl:attribute>
										<xsl:element name="h5"><xsl:text>Ouch! What Bit You?</xsl:text></xsl:element>
										<xsl:element name="a">
											<xsl:attribute name="onclick"><xsl:text>return sl(this,'','ss-default-tile-2');</xsl:text></xsl:attribute>
											<xsl:attribute name="href"><xsl:text>/www/allergies/slideshow-bad-bugs</xsl:text></xsl:attribute>
											<xsl:text>From spider bites to bee stings, see their marks.</xsl:text>
										</xsl:element>
									</xsl:element>
									<xsl:element name="div">
									<xsl:attribute name="class"><xsl:text>clearing</xsl:text></xsl:attribute>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				
			</xsl:otherwise>
			
			
			</xsl:choose>
			
			</xsl:element>

			<xsl:element name="script">
				<xsl:attribute name="type"><xsl:text>text/javascript</xsl:text></xsl:attribute>
				<xsl:text disable-output-escaping="yes"><![CDATA[
				
								webmd.m.mobileSwipeshow=webmd.object(webmd.m.swipeshow,{slideContainer:'.ss_slide',
										
										/* gets called after init by webmd.m.swipeshow */
										dSlides:function() {
											this._buildNav();
											this.resetOrientation();

											/* temporary until we decide if we want it permanently */
											if(webmd.useragent.getTouch()){											
												this.slides.eq(0).prepend('<div class="swipe_instruction">Swipe the photo for the next slide</div>');											
												setTimeout("$('div.ss_slides:first').find('div.swipe_instruction').fadeIn()",1);
											} 
											
											return this;
										},
										
										/* gets called after every slide transition by webmd.m.swipeshow */
										fAfter:function(){
											this.metricsAdRefresh({selector:'#top_ad,#bottom_ad'});
											this.metricsPV();
											this.metricsXML;
									
											this._resetNav();
											
											/* for dynamic height */
											this.calcWidthHeight();
											this.$container.css('-webkit-transition-duration', '0ms');
											this.$container.css('height',this.height);
											
											/* preloads the images 3 slides down */
											/* grab the image 2 ahead of the one you are on and grab it. This way we stay ahead of the user loading images */
											$(this.slides).eq(this.current+2).find('a.ss_slide_image_link').each(function(){															  												$(this).after('<img src="' + $(this).attr('href') + '" alt="' + $(this).attr('title') + '" class="ss_slide_image" border="0" />');
												$(this).remove();
											});

											return this;											
										},
										
										/* private function to build nav, gets called by dSlides, which is called at the end of init */
										_buildNav:function(){	
											var a = this;
											
											this.$container.parent().find("a.ss_nav_prev").click(function(){a.trans("-1"); wmdPageLink('ss_prev'); return false;});
											this.$container.parent().find("a.ss_nav_next").click(function(){a.trans("+1"); wmdPageLink('ss_next'); return false;});
											
											if(this.current == 0) {
												this.$container.parent().find("a.ss_nav_prev").hide();
											}
											
											this.$container.parent().find(".ss_num_length").html(this.slides.length);
											
											this.$container.parent().find(".ss_nav").css('visibility','visible');
											this.$container.parent().find(".ss_num").css('visibility','visible');
																																												
										}, 
										
										/* private function to reset nav on every slide view, to make sure we have the previous and next arrows right */
										_resetNav:function() {
											this.$container.parent().find("a.ss_nav_prev").show();
											this.$container.parent().find("a.ss_nav_next").show();
											
											if(this.current == 0) {	this.$container.parent().find("a.ss_nav_prev").hide(); }

											if((this.current+1) == this.slides.length) { 
												this.$container.parent().find("a.ss_nav_next").hide(); 
												
												]]></xsl:text>
											
											<xsl:if test="//webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/slide_has_redirect_link='true'">
												<xsl:text><![CDATA[ 
												this.seamlessSS = setTimeout('window.location.href = " ]]></xsl:text>
												<xsl:call-template name="GetURLRef">
													<xsl:with-param name="ObjectID">
														<xsl:value-of select="//webmd_rendition/content/wbmd_asset/webmd_module/module_data/slide_redirect/slide_redirect_link/@chronic_id"></xsl:value-of>
													</xsl:with-param>
												</xsl:call-template>
												<xsl:text><![CDATA[";', 3000);]]></xsl:text>
											</xsl:if>
											
											<xsl:text disable-output-escaping="yes"><![CDATA[
											
											}
											else { clearTimeout(this.seamlessSS); }
											
											this.$container.parent().find(".ss_num_current").html(this.current+1);
										},
										
										/* adding image resetting to default orientation change function as the product owner didn't want the images full width when in landscape */
										resetOrientation : function() {
											webmd.m.swipeshow.resetOrientation.call(this);
											
											var self = this; 
											
											switch(window.orientation){
												case 0:
													self.slides.find('img.ss_slide_image').css('width','100%');
													break;   
												case -90:
												case 90:
													self.slides.find('img.ss_slide_image').css('width','85%');
													break;
											}	
										}
									});
									
									$(function(){
										$("div.ss_slides").each(function(){
											var ss=webmd.object(webmd.m.mobileSwipeshow,{container:this});
											ss.init();
											// wakes up iphone so it responds to clicks faster
											ss.trans('0');
										})
									 });
				
				]]></xsl:text>
			</xsl:element>
		
		<div class="attribution">
			<!-- Reviewer Section -->
			
			<div class="reviewer">
				<p><xsl:call-template name="ReviewedByOnText"></xsl:call-template></p>
			</div>
			
			<!-- Citations Section -->
			
			<div class="sources">
				<div class="dropdown_wrap">
					<div class="dropdown">
						<div class="header">View Sources<div class="arrow_down"></div></div>
						<div class="dropdown_content">
							<p><xsl:apply-templates select="//cons_slideshow/citations"></xsl:apply-templates></p>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Disclaimer Section -->
			<p>This tool does not provide medical advice.</p>
      <div class="disclaimer">

	  	<div class="dropdown_wrap">
				<div class="dropdown">
					<div class="header" style="width:145px;">See additional information<div class="arrow_down"></div></div>
					<div class="dropdown_content">
						<p><xsl:value-of select="//wbmd_asset/metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of></p>
					</div>
				</div>
			</div>
			</div>

			<!-- Copyright -->
			<p class="copyright">
				<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
			</p>
			<!-- end attributions -->
		</div>
		</xsl:element>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	<xsl:template name="ReviewedByOnText">
		<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_first_nm or (//wbmd_asset/metadata_section/wbmd_prim_revw_dt !='nulldate')">
			<xsl:choose>
				<xsl:when test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_first_nm">
					<xsl:call-template name="ReviewerText"></xsl:call-template>
					<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_revw_dt !='nulldate'">
						<xsl:text> on </xsl:text>
						<xsl:call-template name="Convert_Date">
							<xsl:with-param name="date">
								<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_prim_revw_dt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					Reviewed on 
					<xsl:call-template name="Convert_Date">
						<xsl:with-param name="date">
							<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_prim_revw_dt"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--  xsl:template name="ReviewerText"   -->
	<xsl:template name="ReviewerText">
		<xsl:if test="//metadata_section/wbmd_prim_med_revr/wbmd_first_nm">
			Reviewed by 
			<xsl:variable name="furl2">
				<xsl:call-template name="GetURLRef">
					<xsl:with-param name="ObjectID">
						<xsl:value-of select="//metadata_section/wbmd_prim_med_revr/wbmd_bio_obj_id/@chronic_id"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$furl2!=''">
					<a onclick="return sl(this,'','review-lnk');" target="_blank" href="{$furl2}">
						<xsl:value-of select="concat(//metadata_section/wbmd_prim_med_revr/wbmd_first_nm, ' ')"></xsl:value-of>
						<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name">
							<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name, ' ')"></xsl:value-of>
						</xsl:if>
						<xsl:value-of select="//metadata_section/wbmd_prim_med_revr/wbmd_lst_nm"></xsl:value-of>
						<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_person_suffix_group/wbmd_person_suffix">
							<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
						</xsl:for-each>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(//metadata_section/wbmd_prim_med_revr/wbmd_first_nm, ' ')"></xsl:value-of>
					<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name">
						<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name, ' ')"></xsl:value-of>
					</xsl:if>
					<xsl:value-of select="//metadata_section/wbmd_prim_med_revr/wbmd_lst_nm"></xsl:value-of>
					<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_person_suffix_group/wbmd_person_suffix">
						<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--   DATE CONVERSION TEMPLATES -->
	<xsl:template name="Convert_Date">
		<xsl:param name="date"></xsl:param>
		<xsl:if test="$date != 'nulldate'">
			<xsl:variable name="monthpart">
				<xsl:variable name="buffmonth">
					<xsl:value-of select="substring-before($date,'/')"></xsl:value-of>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="string-length($buffmonth) = 1">
						<xsl:value-of select="concat('0',$buffmonth)"></xsl:value-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$buffmonth"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="daypart">
				<xsl:variable name="buffday">
					<xsl:value-of select="substring-before(substring-after($date,'/'),'/')"></xsl:value-of>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="string-length($buffday) = 1">
						<xsl:value-of select="concat('0',$buffday)"></xsl:value-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$buffday"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="yearpart">
				<xsl:value-of select="substring(substring-after(substring-after($date,'/'),'/'),1,4)"></xsl:value-of>
			</xsl:variable>
			<xsl:variable name="month">
				<xsl:call-template name="GetMonthString">
					<xsl:with-param name="monthno">
						<xsl:value-of select="$monthpart"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="concat($month,concat($daypart, concat(', ',$yearpart)))"></xsl:value-of>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetMonthString">
		<xsl:param name="monthno"></xsl:param>
		<xsl:choose>
			<xsl:when test="$monthno = '01'">
				<xsl:value-of select="' January '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '02'">
				<xsl:value-of select="' February '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '03'">
				<xsl:value-of select="' March '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '04'">
				<xsl:value-of select="' April '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '05'">
				<xsl:value-of select="' May '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '06'">
				<xsl:value-of select="' June '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '07'">
				<xsl:value-of select="' July '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '08'">
				<xsl:value-of select="' August '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '09'">
				<xsl:value-of select="' September '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '10'">
				<xsl:value-of select="' October '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '11'">
				<xsl:value-of select="' November '"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$monthno = '12'">
				<xsl:value-of select="' December '"></xsl:value-of>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- END DATE CONVERSION TEMPLATES -->
	
	
	
	
	
	
	
	
	
	<xsl:template name="CreateCaptionDivs">
		
			<xsl:for-each select="slide_group">
				<xsl:element name="div">
					<xsl:attribute name="class"><xsl:text>ss_slide</xsl:text></xsl:attribute>
					
					<xsl:choose>
					
					<xsl:when test="position() &lt; 4">			
						<xsl:element name="img">
							<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:call-template name="GetLowResImage"><xsl:with-param name="Value"><xsl:value-of select="slide_img/@path"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="slide_title"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="class">ss_slide_image</xsl:attribute>
							<xsl:attribute name="border">0</xsl:attribute>
						</xsl:element>					
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="a">
							<xsl:attribute name="class"><xsl:text>ss_slide_image_link</xsl:text></xsl:attribute>
							<xsl:attribute name="href"><xsl:value-of select="$image_server_url"></xsl:value-of>
							<xsl:call-template name="GetLowResImage"><xsl:with-param name="Value"><xsl:value-of select="slide_img/@path"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="slide_title"></xsl:value-of></xsl:attribute>
						</xsl:element>	
					</xsl:otherwise>					
					</xsl:choose>
					
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>ss_slide_text</xsl:text></xsl:attribute>
						<xsl:if test="slide_caption_title!=''">
							<xsl:element name="h3">
								<xsl:value-of select="slide_caption_title" disable-output-escaping="yes"></xsl:value-of>
							</xsl:element>
						</xsl:if>
						<xsl:for-each select="slide_caption_text/node()">
							<xsl:call-template name="CopyNodes"></xsl:call-template>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			
			
	
	</xsl:template>
	
	
	
	<xsl:template name="GetLowResImage">
				<xsl:param name="Value"></xsl:param>
				<xsl:value-of select="substring-before($Value,'.jpg')"/><xsl:text>.jpg</xsl:text>
			</xsl:template>
	
	
	
	
	
	
	<xsl:template name="CreateNavDiv">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>ss_num</xsl:text></xsl:attribute>
			<xsl:element name="span">
				<xsl:attribute name="class"><xsl:text>ss_num_current</xsl:text></xsl:attribute>
				<xsl:text>1</xsl:text>
			</xsl:element>
			<xsl:text>/</xsl:text>
			<xsl:element name="span">
				<xsl:attribute name="class"><xsl:text>ss_num_length</xsl:text></xsl:attribute>
				<xsl:text>1</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>ss_nav</xsl:text></xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="href"></xsl:attribute>
				<xsl:attribute name="class"><xsl:text>ss_nav_next</xsl:text></xsl:attribute>
				<xsl:element name="div">
					<xsl:attribute name="class"><xsl:text>arrow_right</xsl:text></xsl:attribute>
					<xsl:text>Next</xsl:text>
				</xsl:element>
				
			</xsl:element>
			<xsl:element name="a">
				<xsl:attribute name="href"></xsl:attribute>
				<xsl:attribute name="class"><xsl:text>ss_nav_prev</xsl:text></xsl:attribute>
				<xsl:element name="div">
					<xsl:attribute name="class"><xsl:text>arrow_left</xsl:text></xsl:attribute>
					<xsl:text>Previous</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	<!--This template is used to create duplicate nodes from the source. It used to avoid the default namespace insertion caused when xsl:copy-of is used.-->
	<xsl:template name="CopyNodes">
		<xsl:choose>
			<xsl:when test="name()!=''">
				<xsl:element name="{name()}" namespace="{namespace-uri()}">
					<xsl:copy-of select="@*"></xsl:copy-of>
					<xsl:for-each select="node()">
						<xsl:call-template name="CopyNodes"></xsl:call-template>
					</xsl:for-each>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."></xsl:value-of>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	<xsl:template name="GetLinkType">
		<xsl:param name="Value"></xsl:param>
		<xsl:choose>
			<xsl:when test="$Value = 'Window' or $Value = 'New Window – 1000x600'">nw</xsl:when>
			<xsl:when test="$Value = 'Pop Up' or $Value = 'Small Pop Up - 380x210'">sp</xsl:when>
			<xsl:when test="$Value = 'SDC Pop Up – 600x700'">sdp</xsl:when>
			<xsl:when test="$Value = 'Scrollable Pop Up – 530x490'">scp</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="GetURLRef">
		<xsl:param name="ObjectID"></xsl:param>
		<xsl:if test="(//referenced_objects/object[@chronic_id=$ObjectID and @pointer='0']/target[@siteid=$site_id]/@friendlyurl) or (//referenced_objects/object[@chronic_id=$ObjectID and @pointer='1']/target/@friendlyurl)">
			<xsl:choose>
				<xsl:when test="//referenced_objects/object[@chronic_id=$ObjectID]//@pointer = '1'">
					<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target/@friendlyurl"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>http://<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@prefix[1]"></xsl:value-of>.<xsl:value-of select="$domain"></xsl:value-of>
					<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@friendlyurl[1]"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetOnclickVal">
		<xsl:param name="link_type"></xsl:param>
		<xsl:param name="tracking_val"></xsl:param>
		<xsl:text>return sl(this,'</xsl:text>

		<xsl:value-of select="$link_type"></xsl:value-of>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="$tracking_val"></xsl:value-of>
		<xsl:text>');</xsl:text>
	</xsl:template>
	<xsl:template name="GetImg">
		<xsl:param name="src"></xsl:param>
		<xsl:param name="alt"></xsl:param>
		<img src="{$src}" alt="{$alt}"/>
	</xsl:template>
</xsl:stylesheet>

