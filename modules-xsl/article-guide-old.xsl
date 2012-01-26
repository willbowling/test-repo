<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xalan" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xalan-nodeset="org.apache.xalan.xslt.extensions.Nodeset" xmlns:fn="http://www.w3.org/TR/2006/PR-xpath-functions-20061121/" exclude-result-prefixes="xsl fn java xalan xalan-nodeset">
	<xsl:output method="html" omit-xml-declaration="yes" encoding="ISO-8859-1"></xsl:output>
	<xsl:param name="class_id"></xsl:param>
	<xsl:param name="image_server_url">
		<xsl:text>http://img.preview.webmd.com/dtmcms/preview</xsl:text>
	</xsl:param>
	<xsl:param name="moduletitle"></xsl:param>
	<xsl:param name="site_id">3</xsl:param>
	<xsl:param name="domain">webmd.com</xsl:param>
	<xsl:param name="current_page">3</xsl:param>
	<xsl:param name="first_page">1</xsl:param>
	<xsl:param name="last_page">3</xsl:param>
	<xsl:param name="print">false</xsl:param>
	<xsl:param name="spon"></xsl:param>
	<xsl:param name="pg_furl"></xsl:param>
	<xsl:param name="prefix"></xsl:param>
	<!-- Begin of Additional Pagination Variables -->
	<xsl:variable name="pl_test">
		<!--Pagination Location-->
		<xsl:value-of select="webmd_rendition/content/wbmd_asset/metadata_section/i_chronicle_id"></xsl:value-of>
	</xsl:variable>
	<xsl:variable name="pagination_test"><!-- Only applies the omniture test to articles with the following Chron IDs -->
		<xsl:choose>
			<xsl:when test="$pl_test = '091e9c5e80008bd6' or  $pl_test = '091e9c5e800db10f'">
				<xsl:text>true</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="sections_per_page">
		<xsl:text>1</xsl:text>
	</xsl:variable>
	<!-- End of Additional Pagination Variables -->
	
	<!-- 
	
	*** All the comments in this XSL surrounded by *** are there for the mobile display format ***

	THIS TEMPLATE HANDLES THE FOLLOWING ARTICLE TYPES
		1.	BIOGRAPHY - Tested
		2.	COMPANY PROFILE - Tested
		3.	FAQ - Tested
		4.	FEATURE - Tested
		5.	HEALTH REFERENCE - Tested
		6. NEWS - Tested
		7. HW - ACTIONSET - Tested
		8. HW - DECISION POINT - Tested
		9. HW - DEFINITION - Tested
		10. HW - MAJOR - Tested
        11. HW - MINI - Tested
        12. HW - SPECIAL - Tested
        13. HW - TEST DETAIL - Tested
        14. HW - SURGICAL DETAIL - Tested
        15. HW - OTHER DETAIL - Tested
	    16. HW - NCI - Tested
		17. HW - NORD - Tested
		18. HW - SHC - Tested
		19. HW - Frame - Tested
		20. HW - Support - Tested	
		21. HW - Multimedia - In Progress
		22. HW - Drug Detail - Tested
		23. HW - Medical Test - Tested
		24. HW - Symptoms
		25. HW - Symptoms - Check Your Symptoms
		26. HW - Symptoms - Emergency
		
	-->
	<xsl:template match="/">
		<xsl:apply-templates select="//cons_bio"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_company_profile"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_faq"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_feature"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_health_ref"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_news"></xsl:apply-templates>
		<xsl:apply-templates select="//cons_import_health_ref"></xsl:apply-templates>
	</xsl:template>
	
	
	
	
	
	
	
	<!--- BIOGRAPHY ARTICLE -->
	<xsl:template match="cons_bio">
		<!-- article content -->
		<div class="article">
			<!-- biography -->
			<div class="biography">
				<!--div class="Padding"-->
				<div id="textArea" class="copyNormal">
					<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="share_bar"></xsl:call-template>-->
					<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
					<xsl:choose>
						<xsl:when test="string(person_photo/@path) and (person_photo/@path !='/webmd/consumer_assets')">
							<div class="bioBox">
								<div class="imageHolder">
									<img src="{$image_server_url}{person_photo/@path}" border="0" alt="{person_photo/@alt}"/>
								</div>
							</div>
							<h2>
								<xsl:value-of select="title"></xsl:value-of>
							</h2>
						</xsl:when>
						<xsl:otherwise>
							<h2 class="no-image">
								<xsl:value-of select="title"></xsl:value-of>
							</h2>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="bio_text"></xsl:apply-templates>
				</div>
			</div>
			<div class="bottom"></div>
		</div>
	</xsl:template>
	







	<!--- FAQ TEMPLATES -->
	<!-- For FAQ Multi -->
	<xsl:template match="cons_faq[count(//question_and_answer_group) > 1]">

		<script src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/javascript/faq.js"></script>
		<div class="article">
			<xsl:call-template name="ArchiveNotation">
				<xsl:with-param name="boolInd">
					<xsl:value-of select="//metadata_section/wbmd_archive_bool"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="storageVal">
					<xsl:value-of select="//metadata_section/wbmd_bus_ref/@wbmd_storage_val"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="subhead">
					<xsl:value-of select="subheadline"></xsl:value-of>
				</div>
				<!-- FAQ Multiple QA Content -->
				<div class="faqMultipleQA">
					<ul class="faq" id="FAQ">
						<xsl:apply-templates select="question_and_answer_groups/question_and_answer_group" mode="multi"></xsl:apply-templates>
					</ul>
					<div class="button">
						<div class="buttonLeft">
							<div class="buttonRight">
								<a href="http://www.webmd.com/community/boards" onclick="return sl(this,'','embd-lnk');">Ask Your Question</a>
							</div>
						</div>
					</div>
				</div>
				<!-- end FAQ multiple QA content -->
			</div>
	
			<!-- end article content -->
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- attributions -->
			<xsl:call-template name="faq_attribution"></xsl:call-template>
			<!-- <xsl:apply-templates select="//wbmd_asset/metadata_section"/>  -->
			<!-- end attributions -->
			<xsl:if test="/webmd_rendition/section_groups/section_group">
				<xsl:call-template name="GuideFeedback"></xsl:call-template>
			</xsl:if>
			<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- For FAQ Single -->
	<xsl:template match="cons_faq[count(//question_and_answer_group) = 1]">

		<!-- article content -->
		<div class="article">
			<xsl:call-template name="ArchiveNotation">
				<xsl:with-param name="boolInd">
					<xsl:value-of select="//metadata_section/wbmd_archive_bool"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="storageVal">
					<xsl:value-of select="//metadata_section/wbmd_bus_ref/@wbmd_storage_val"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
			<div class="faqSingleQA">
				<div id="textArea" class="copyNormal">
					<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="share_bar"></xsl:call-template> -->
					<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template> -->
					<h2>
						<xsl:value-of select="title"></xsl:value-of>
					</h2>
					<div class="subhead">
						<xsl:value-of select="subheadline"></xsl:value-of>
					</div>
					<div class="author">
						<xsl:call-template name="AuthorText"></xsl:call-template>
						<br/>
						<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
					</div>
					<xsl:apply-templates select="question_and_answer_groups/question_and_answer_group" mode="single"></xsl:apply-templates>
				</div>
			</div>
		
			<!-- end article content -->
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- attributions -->
			<xsl:call-template name="faq_attribution"></xsl:call-template>
			<!--<xsl:apply-templates select="//wbmd_asset/metadata_section"/>-->
			<!-- end attributions -->
			<xsl:if test="/webmd_rendition/section_groups/section_group">
				<xsl:call-template name="GuideFeedback"></xsl:call-template>
			</xsl:if>
			<div class="bottom"></div>
		</div>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	<!--  FEATURE TEMPLATE -->
	<xsl:template match="cons_feature">
	
		<!-- article content -->

		<div class="article">
			<div id="textArea" class="copyNormal">
				<xsl:call-template name="feature_archive_2"></xsl:call-template>
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="subhead">
					<xsl:value-of select="subheadline"></xsl:value-of>
					<xsl:if test="$current_page != $first_page">
						<div class="continued"> (continued)</div>
					</xsl:if>
				</div>
				<!-- If this is first page render author section -->
				<xsl:if test="$current_page = $first_page">
					<div class="byline">
						<div class="author">
							<xsl:call-template name="AuthorText"></xsl:call-template>				
						</div>
						<div class="reviewer">
							<xsl:call-template name="ReviewerText"></xsl:call-template>
						</div>
						<div class="publication">
							<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						</div>
					</div>
				</xsl:if>
				<!-- End Author Area -->
				<!-- Begin Content Area -->
				<xsl:choose>
					<xsl:when test="$print = 'True'">
						<xsl:apply-templates select="pages/page/section_group"></xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="pages/page[number($current_page)]/section_group"></xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</div>
			

			<!-- render pagination if total pages > 1 -->
			<xsl:if test="$first_page != $last_page">
				<xsl:call-template name="Pagination"></xsl:call-template>
			</xsl:if>
	
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- attributions -->
			<div class="attribution">
				<p class="medical_reference"></p>
				<xsl:if test="$current_page = $last_page">
					<xsl:if test="string(citations)">
						<div class="sources">
							<div class="dropdown_wrap">
								<div class="dropdown">
									<div class="header">View Article Sources<div class="arrow_down"></div></div>
									<div class="dropdown_content">
										<xsl:apply-templates select="citations"></xsl:apply-templates>
									</div>
								</div>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="//metadata_section/wbmd_prim_revw_dt and (//metadata_section/wbmd_prim_revw_dt !='nulldate')">
						<p>
						Reviewed on
							<xsl:call-template name="Convert_Date">
								<xsl:with-param name="date">
									<xsl:value-of select="//metadata_section/wbmd_prim_revw_dt"></xsl:value-of>
								</xsl:with-param>
							</xsl:call-template>
						</p>
					</xsl:if>
					<!--Editor Section -->
					<xsl:call-template name="EditedByOnText"></xsl:call-template>
					<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
						<p class="copyright">
							<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
						</p>
					</xsl:if>
					
				</xsl:if>
			</div>
	
			<!-- end attributions -->
			<xsl:if test="/webmd_rendition/section_groups/section_group">
				<xsl:call-template name="GuideFeedback"></xsl:call-template>
			</xsl:if>
			
			<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- END FEATURE TEMPLATE -->
	
	
	
	
	
	
	
	
	
	<!-- HEATH REFERENCE TEMPLATE -->
	<xsl:template match="cons_health_ref">

		<!-- article content -->
			<xsl:choose>
				<xsl:when test="$pagination_test = 'true'">
					<xsl:call-template name="cons_healt_ref_new_pagination"></xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<div class="article">
						<div id="textArea" class="copyNormal">
							<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
							<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
							<h2>
								<xsl:value-of select="title"></xsl:value-of>
							</h2>
							<div class="subhead">
								<xsl:if test="$current_page != $first_page">
									<div class="continued"> (continued)</div>
								</xsl:if>
							</div>
							<!-- Begin Content Area -->
							<xsl:choose>
								<xsl:when test="$print = 'True'">
									<xsl:apply-templates select="pages/page/section_group"></xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="pages/page[number($current_page)]/section_group"></xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</div>

						<!-- render pagination if total pages > 1 -->
						<xsl:if test="$first_page != $last_page">
							<xsl:call-template name="Pagination"></xsl:call-template>
						</xsl:if>
						<!-- render Attributions if last page -->
						<xsl:if test="//cons_topic_outline/section_groups/section_group">
							<xsl:call-template name="TopicPulldown"></xsl:call-template>
						</xsl:if>
		
						<!-- attributions -->
						<!-- attributions -->
						<div class="attribution">
							<p class="medical_reference">
									<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
									<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
										<img src="{$image_server_url}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path}" height="19" border="0" alt="{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt}"/>
									</xsl:if>
								<div class="clearBoth"></div>
							</p>
							<!-- end attributions -->
							<xsl:if test="$current_page = $last_page">
								<xsl:if test="string(citations)">
									<div class="sources">
										<div class="dropdown_wrap">
											<div class="dropdown">
												<div class="header">View Article Sources<div class="arrow_down"></div></div>
												<div class="dropdown_content">
													<xsl:apply-templates select="citations"></xsl:apply-templates>
												</div>
											</div>
										</div>
									</div>
								</xsl:if>
								<!-- Reviewer Section -->
								<xsl:call-template name="ReviewedByOnText"></xsl:call-template>
								<!-- Begin Editor Section -->
								<xsl:call-template name="EditedByOnText"></xsl:call-template>
								<xsl:if test="//wbmd_asset/metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
									<p class="warning">
										<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
									</p>
								</xsl:if>
								<xsl:if test="//wbmd_asset/metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
									<p class="copyright">
										<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
									</p>
								</xsl:if>
								
								<!-- end attributions -->
							</xsl:if>
							<xsl:if test="/webmd_rendition/section_groups/section_group">
								<xsl:call-template name="GuideFeedback"></xsl:call-template>
							</xsl:if>
						</div>
						<div class="bottom"></div>
					</div>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	
	
	
	<xsl:template name="cons_healt_ref_new_pagination">
	<!--Variable below used to determine placement of the contextual related links-->
		<xsl:variable name="new_last_page">
			<xsl:value-of select="ceiling(count(/webmd_rendition/content/wbmd_asset/content_section/*/pages/page/section_group) div number($sections_per_page))"></xsl:value-of>
		</xsl:variable>
		<!-- article content -->
		<div class="article">
			<div id="textArea" class="copyNormal">
						<h2>
							<xsl:value-of select="title"></xsl:value-of>
						</h2>
						<div class="subhead">
							<xsl:if test="$current_page != $first_page">
								<div class="continued"> (continued)</div>
							</xsl:if>
						</div>
						<!-- Begin Content Area -->
						<xsl:choose>
							<xsl:when test="$print = 'True'">
								<xsl:apply-templates select="pages/page/section_group"></xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
									<xsl:for-each select="pages/page/section_group">
									<xsl:if test="position() &gt; number(($current_page - 1) * number($sections_per_page)) and position() &lt; number(($current_page * number($sections_per_page)) + 1)">
										<xsl:apply-templates select="."></xsl:apply-templates>
									</xsl:if>
								</xsl:for-each>							
								</xsl:otherwise>
						</xsl:choose>
					</div>
			
		<!-- render pagination if total pages > 1 -->
		<xsl:if test="$first_page != $new_last_page">
			<xsl:call-template name="Pagination_new"></xsl:call-template>
		</xsl:if>
		<!-- render Attributions if last page -->
		<xsl:if test="//cons_topic_outline/section_groups/section_group">
			<xsl:call-template name="TopicPulldown"></xsl:call-template>
		</xsl:if>
		<!-- Check For Guide Attribution -->
		<!-- attributions -->
		<!-- attributions -->
		<div class="attribution">
							<p class="medical_reference">
									<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
									<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
										<img src="{$image_server_url}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path}" height="19" border="0" alt="{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt}"/>
									</xsl:if>
								<div class="clearBoth"></div>
							</p>
							<!-- end attributions -->
							<xsl:if test="$current_page = $new_last_page">
								<xsl:if test="string(citations)">
									<div class="sources">
										<div class="dropdown_wrap">
											<div class="dropdown">
												<div class="header">View Article Sources<div class="arrow_down"></div></div>
												<div class="dropdown_content">
													<xsl:apply-templates select="citations"></xsl:apply-templates>
												</div>
											</div>
										</div>
									</div>
								</xsl:if>
								<!-- Reviewer Section -->
								<xsl:call-template name="ReviewedByOnText"></xsl:call-template>
								<!-- Begin Editor Section -->
								<xsl:call-template name="EditedByOnText"></xsl:call-template>
								<xsl:if test="//wbmd_asset/metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
									<p class="warning">
										<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
									</p>
								</xsl:if>
								<xsl:if test="//wbmd_asset/metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
									<p class="copyright">
										<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
									</p>
								</xsl:if>
								
								<!-- end attributions -->
							</xsl:if>
							<xsl:if test="/webmd_rendition/section_groups/section_group">
								<xsl:call-template name="GuideFeedback"></xsl:call-template>
							</xsl:if>
						</div>
		<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- END HEALTH REFERENCE TEMPLATE -->

	
	
	
	
	
	
	<!-- NEWS TEMPLATE -->
	<xsl:template match="cons_news">

		<div class="article">
			<div id="textArea" class="copyNormal">
				<xsl:call-template name="news_archive_2"></xsl:call-template>
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->


				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="subhead">
					<xsl:value-of select="subheadline"></xsl:value-of>
					<xsl:if test="$current_page != $first_page">
						<div class="continued"> (continued)</div>
					</xsl:if>
				</div>
				<!-- If this is first page render author section -->
				<xsl:if test="$current_page = $first_page">
					<div class="byline">
						<div class="author">
							<xsl:call-template name="AuthorText"></xsl:call-template>				
						</div>
						<div class="reviewer">
							<xsl:call-template name="ReviewerText"></xsl:call-template>
						</div>
						<div class="publication">
							<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						</div>
					</div>
				</xsl:if>
				<!-- Begin Content Area -->
				<xsl:choose>
					<xsl:when test="$print = 'True'">
						<xsl:apply-templates select="pages/page/section_group"></xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="pages/page[number($current_page)]/section_group"></xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</div>
			
			<!-- render pagination if total pages > 1 -->
			<xsl:if test="$first_page != $last_page">
				<xsl:call-template name="Pagination"></xsl:call-template>
			</xsl:if>
	
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- render Attributions if last page -->
			<xsl:if test="$current_page = $last_page">
				<!-- attributions -->
				<div class="attribution">
					<xsl:if test="string(citations)">
						<div class="sources">
							<div class="dropdown_wrap">
								<div class="dropdown">
									<div class="header">View Article Sources<div class="arrow_down"></div></div>
									<div class="dropdown_content">
										<xsl:apply-templates select="citations"></xsl:apply-templates>
									</div>
								</div>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
						<p class="copyright">
							<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
						</p>
					</xsl:if>
					
				</div>
				<!-- end attributions -->
			</xsl:if>
			<xsl:if test="/webmd_rendition/section_groups/section_group">
				<xsl:call-template name="GuideFeedback"></xsl:call-template>
			</xsl:if>
		
		<div class="bottom"></div>
		</div>
		
	</xsl:template>
	<!-- END NEWS TEMPLATE -->
	
	
	
	
	
	
	
	
	
	
	<!-- BEGIN ACTIONSET TEMPLATE -->
	<xsl:template match="cons_import_health_ref[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - ActionSet']">
		<script src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/javascript/actionset.js"></script>
		<div class="article" xmlns:xalan="http://xml.apache.org/xalan">
			<div id="textArea" class="copyNormal">
				<div class="headerLink">
					<a href="/www/action-set" onClick="window.open(this.href, 'popup','width=530,height=490,scrollbars=no,resizeable=no,status=yes');return false;">What is an Actionset?</a>
				</div>
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionsetTOC_action_icon.gif" alt="actionset" width="78" height="27" class="headerImg"/>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<!-- <div class="subhead">
					 <xsl:value-of select="normalize-space(//metadata_section/wbmd_c_teaser)"/> 
				</div> -->
				<!-- Begin Content Area -->
				<div class="actionset">
					<xsl:apply-templates select="section_groups/section_group[section_type!='References' and section_type!='Credits']"></xsl:apply-templates>
				</div>
				<xsl:if test="section_groups/section_group[section_type='Credits' or section_type='References']">
					<xsl:apply-templates select="section_groups/section_group[section_type='References']"></xsl:apply-templates>
					<xsl:apply-templates select="section_groups/section_group[section_type='Credits']"></xsl:apply-templates>
				</xsl:if>
			</div>
		
		<xsl:if test="//cons_topic_outline/section_groups/section_group">
			<xsl:call-template name="TopicPulldown"></xsl:call-template>
		</xsl:if>

		<!-- attributions -->
		<div class="attribution">
			<p class="medical_reference">
					<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
					<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
						<img>
							<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt"></xsl:value-of></xsl:attribute>
						</img>
					</xsl:if>
			</p>
			<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
				<p class="last_updated">Last Updated: 
					<xsl:call-template name="Convert_Date">
						<xsl:with-param name="date">
							<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</p>
			</xsl:if>
			<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
				<p class="warning">
					<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
				</p>
			</xsl:if>
			<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
				<p class="copyright">
					<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
				</p>
			</xsl:if>
			
		</div>
		<!-- end attributions -->
			<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- END ACTIONSET TEMPLATE -->
	
	
	
	
	
	
	
	<!-- ACTIONSET OTHER TEMPLATES -->
	<xsl:template match="section_group[section_type = 'Overview']">
		
		<xsl:apply-templates select="section_text" mode="AS"></xsl:apply-templates>

	</xsl:template>
	<xsl:template match="section_group[section_type = 'What']">
		<div>
			<xsl:attribute name="class">section
				<xsl:if test="position() = last()"> last</xsl:if></xsl:attribute>
			<div>
				<xsl:attribute name="class"><xsl:choose><xsl:when test="position() = 1">arrowFirst</xsl:when><xsl:when test="position() = last()">arrowLast</xsl:when><xsl:otherwise>arrow</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:if test="position() = last()">
					<xsl:attribute name="id">lastDiv</xsl:attribute>
				</xsl:if>
				<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_what.gif" alt="What?" class="title"/>
				<div class="vertical1">
					<div class="vertical2">
						<div class="vertical3">
							<a href="#" onclick="showDiv('detailWhat','whatArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;">
								<xsl:value-of select="section_header"></xsl:value-of>
							</a>
						</div>
					</div>
				</div>
				<a href="#" onclick="showDiv('detailWhat','whatArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;" class="link">
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="whatArrw" alt="arrow"/>
				</a>
			</div>
		</div>
		<div class="detail" id="detailWhat">
			<div class="border">
				<div class="innerBorder">
					<div class="content">
						<xsl:apply-templates select="section_text"></xsl:apply-templates>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="section_group[section_type = 'Why']">
		<div>
			<xsl:attribute name="class">section
				<xsl:if test="position() = last()"> last</xsl:if></xsl:attribute>
			<div>
				<xsl:attribute name="class"><xsl:choose><xsl:when test="position() = 1">arrowFirst</xsl:when><xsl:when test="position() = last()">arrowLast</xsl:when><xsl:otherwise>arrow</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:if test="position() = last()">
					<xsl:attribute name="id">lastDiv</xsl:attribute>
				</xsl:if>
				<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_why.gif" alt="Why?" class="title"/>
				<div class="vertical1">
					<div class="vertical2">
						<div class="vertical3">
							<a href="#" onclick="showDiv('detailWhy','whyArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;">
								<xsl:value-of select="section_header"></xsl:value-of>
							</a>
						</div>
					</div>
				</div>
				<a href="#" onclick="showDiv('detailWhy','whyArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;" class="link">
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="whyArrw" alt="arrow"/>
				</a>
			</div>
		</div>
		<div class="detail" id="detailWhy">
			<div class="border">
				<div class="innerBorder">
					<div class="content">
						<xsl:apply-templates select="section_text"></xsl:apply-templates>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="section_group[section_type = 'Credits' and (//metadata_section/wbmd_publ/wbmd_publ_name != 'Healthwise - MultiMedia')]">
		<div class="dashed"></div>
		<div class="subheadSpaced"></div>
		<div class="credits">
			<xsl:apply-templates select="section_text"></xsl:apply-templates>
		</div>
	</xsl:template>
	<xsl:template match="section_group[(position() = 1) and ((//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - MultiMedia') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Frame') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Definition'))]">
		<xsl:apply-templates select="section_text"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_group[section_type = 'References']">
		<xsl:apply-templates select="section_text"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_group[section_type = 'How']">
		<div>
			<xsl:attribute name="class">section
				<xsl:if test="position() = last()"> last</xsl:if></xsl:attribute>
			<div>
				<xsl:attribute name="class"><xsl:choose><xsl:when test="position() = 1">arrowFirst</xsl:when><xsl:when test="position() = last()">arrowLast</xsl:when><xsl:otherwise>arrow</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:if test="position() = last()">
					<xsl:attribute name="id">lastDiv</xsl:attribute>
				</xsl:if>
				<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_how.gif" alt="How?" class="title"/>
				<div class="vertical1">
					<div class="vertical2">
						<div class="vertical3">
							<a href="#" onclick="showDiv('detailHow','howArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;">
								<xsl:value-of select="section_header"></xsl:value-of>
							</a>
						</div>
					</div>
				</div>
				<a href="#" onclick="showDiv('detailHow','howArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif'); return false;" class="link">
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="howArrw" alt="arrow"/>
				</a>
			</div>
		</div>
		<div class="detail" id="detailHow">
			<div class="border">
				<div class="innerBorder">
					<div class="content">
						<xsl:apply-templates select="section_text"></xsl:apply-templates>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="section_group[section_type = 'Where']">
		<div>
			<xsl:attribute name="class">section last</xsl:attribute>
			<div>
				<xsl:attribute name="class">arrowLast</xsl:attribute>
				<xsl:attribute name="id">lastDiv</xsl:attribute>
				<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where.gif" alt="Where?" class="title" id="lastDivImg2"/>
				<div class="vertical1">
					<div class="vertical2">
						<div class="vertical3">
							<a href="#" onclick="showDiv('detailWhere','whereArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');lastDivSwap('lastDiv','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where_on.gif','arrowLast','arrow'); return false;">
								<xsl:value-of select="section_header"></xsl:value-of>
							</a>
						</div>
					</div>
				</div>
				<div>
					<a href="#" onclick="showDiv('detailWhere','whereArrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');lastDivSwap('lastDiv','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where_on.gif','arrowLast','arrow'); return false;" class="link">
						<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="whereArrw" alt="arrow"/>
					</a>
				</div>
			</div>
		</div>
		<div class="detail" style="border-top:none;" id="detailWhere">
			<div class="border">
				<div class="innerBorder">
					<div class="content">
						<xsl:apply-templates select="section_text"></xsl:apply-templates>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="block.quiz">
		<div class="testYourKnowledge">
			<p class="testKnowHeader">
				<xsl:apply-templates select="quiz.intro"></xsl:apply-templates>
			</p>
			<xsl:apply-templates select="quiz.questions/quiz.question">
				<xsl:with-param name="parentid">
					<xsl:value-of select="count(parent::*/parent::*/preceding-sibling::*)"></xsl:value-of>
				</xsl:with-param>
			</xsl:apply-templates>
		</div>
		<a name="fms_answer{count(parent::*/parent::*/preceding-sibling::*)}"></a>
		<div id="answer{count(parent::*/parent::*/preceding-sibling::*)}" class="answer">
			<div class="answerBoxContainer">
				<xsl:apply-templates select="quiz.questions/quiz.question/question.answers/question.answer" mode="question"></xsl:apply-templates>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="quiz.question">
		<xsl:param name="parentid"></xsl:param>
		<xsl:apply-templates select="question.text"></xsl:apply-templates>
		<form name="testKnowledge{$parentid}">
			<xsl:apply-templates select="question.answers/question.answer" mode="select">
				<xsl:with-param name="parentid" select="$parentid"></xsl:with-param>
			</xsl:apply-templates>
		</form>
	</xsl:template>
	<xsl:template match="quiz.intro">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="question.answer" mode="select">
		<xsl:param name="parentid"></xsl:param>
		<input type="radio" name="answer_{$parentid}" value="{position() -1}" onclick="gradeAnswer(this.value, 'answer{$parentid}');"/>>
    <xsl:value-of select="answer.text"></xsl:value-of>
		<xsl:if test="position() != last()">
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="question.answer" mode="question">
		<p class="answerDisplay" style="display:none;">
			<span class="answerBoxLabel">This answer is 
				<xsl:choose>
					<xsl:when test="@correct='yes'">correct</xsl:when>
					<xsl:otherwise>incorrect</xsl:otherwise>
				</xsl:choose>.
			</span>
			<br/>
			<xsl:value-of select="answer.explanation"></xsl:value-of>
		</p>
	</xsl:template>
	<xsl:template match="question.text">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<!-- END ACTIONSET OTHER TEMPLATES -->
	
	
	
	
	
	
	
	<!-- BEGIN DECISION POINT TEMPLATES -->
	<xsl:template match="cons_import_health_ref[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - DecisionPoint']">
		<script src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/javascript/actionset.js"></script>
		<div class="article">
			<div id="textArea" class="copyNormal">
				<div class="headerLink">
					<a href="/www/decision-point" onClick="window.open(this.href, 'popup','width=530,height=490,scrollbars=no,resizeable=no,status=yes');return false;">What is a Decision Point?</a>
				</div>
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionsetTOC_decsion_pt.jpg" alt="decision point" width="77" height="20" class="headerImg"/>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<!-- Begin Content Area -->
				<div class="decisionPoint">
					<xsl:apply-templates select="section_groups/section_group" mode="DP"></xsl:apply-templates>
				</div>
			</div>
			

			<!-- attributions -->
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<div class="attribution">
					<p class="medical_reference">
						<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
							<img>
								<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt"></xsl:value-of></xsl:attribute>
							</img>
						</xsl:if>
					</p>
				<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
					<p class="last_updated">Last Updated: 
						<xsl:call-template name="Convert_Date">
							<xsl:with-param name="date">
								<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
					<p class="warning">
						<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
					<p class="copyright">
						<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
					</p>
				</xsl:if>
				
			</div>
		<!-- end attributions -->
		<div class="bottom"></div>
		</div>
	</xsl:template>
	<xsl:template match="section_group" mode="DP">
		<xsl:apply-templates select="section_header" mode="DP">
			<xsl:with-param name="group_no">
				<xsl:value-of select="position()"></xsl:value-of>
			</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="section_text" mode="DP">
			<xsl:with-param name="group_no">
				<xsl:value-of select="position()"></xsl:value-of>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_header" mode="DP">
		<xsl:param name="group_no"></xsl:param>
		<div>
			<xsl:attribute name="class">section <xsl:if test="number($group_no) = count(//section_groups/section_group)"> last</xsl:if></xsl:attribute>
			<div>
				<xsl:attribute name="class"><xsl:choose><xsl:when test="$group_no = 1">arrowFirst</xsl:when><xsl:when test="$group_no = count(//section_groups/section_group)">arrowLast</xsl:when><xsl:otherwise>arrow</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:if test="$group_no = count(//section_groups/section_group)">
					<xsl:attribute name="id">lastDiv</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$group_no = 1">
						<div class="leftBorder">
							<div class="rounded">
								<div class="vertical1">
									<div class="vertical2">
										<div class="vertical3">
											<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');this.blur(); return false;">
												<xsl:value-of select="."></xsl:value-of>
											</a>
										</div>
									</div>
								</div>
								<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');this.blur(); return false;" class="link">
									<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="DP{$group_no}Arrw" alt="arrow"/>
								</a>
							</div>
						</div>
					</xsl:when>
					<xsl:when test="$group_no = count(//section_groups/section_group)">
						<div class="vertical1">
							<div class="vertical2">
								<div class="vertical3">
									<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');lastDivSwap('lastDiv','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where_on.gif','arrowLast','arrowLast2');this.blur(); return false;">
										<xsl:value-of select="."></xsl:value-of>
									</a>
								</div>
							</div>
						</div>
						<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');lastDivSwap('lastDiv','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_where_on.gif','arrowLast','arrowLast2');this.blur(); return false;" class="link">
							<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="DP{$group_no}Arrw" alt="arrow"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<div class="vertical1">
							<div class="vertical2">
								<div class="vertical3">
									<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');this.blur(); return false;">
										<xsl:value-of select="."></xsl:value-of>
									</a>
								</div>
							</div>
						</div>
						<a href="#" onclick="showDiv('detail{$group_no}','DP{$group_no}Arrw','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif','{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw_on.gif');this.blur(); return false;" class="link">
							<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/actionset_arrw.gif" class="arrw" id="DP{$group_no}Arrw" alt="arrow"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="section_text" mode="DP">
		<xsl:param name="group_no"></xsl:param>
		<div class="detail" id="detail{$group_no}">
			<xsl:if test="group_no = count(//section_groups/section)">
				<xsl:attribute name="style">border-top:none;</xsl:attribute>
			</xsl:if>
			<div class="border">
				<div class="innerBorder">
					<div class="content">
						<xsl:apply-templates></xsl:apply-templates>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="section_text" mode="AS">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="p[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - ActionSet') and (parent::section_text/parent::section_group/section_type = 'Overview') and (preceding-sibling::ul[position()=last()]) and (preceding-sibling::h4)]"></xsl:template>
	<!-- END DECISION POINT TEMPLATES -->
	
	
	
	
	
	
	
	<!-- BEGIN MAJOR, MINI, \, DEFINITION, ETC -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Definition') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Major') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Mini') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Special') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Test Detail') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Surgical Detail') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Other Detail') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Frame') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Support') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Drug Detail')  or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Medical Test') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Symptom')]">
		
		
		<xsl:variable name="isPaginated">
			<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Major') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Mini') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Special') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI' ) or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Symptom' ) or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Medical Test' )">true</xsl:if>
		</xsl:variable>
		<div class="article">
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title" disable-output-escaping="yes"></xsl:value-of>
				</h2>
				<xsl:if test="$isPaginated = 'true'">
					<div class="subhead">
						<xsl:if test="$current_page != $first_page">
							<div class="continued"> (continued)</div>
						</xsl:if>
					</div>
				</xsl:if>
				<!-- Begin Content Area -->
				<div class="hwDefinition">
					<xsl:choose>
						<xsl:when test="$isPaginated = 'true'">
							<xsl:choose>
								<xsl:when test="$print = 'True'">
									<xsl:apply-templates select="pages/page/section_group"></xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="pages/page[number($current_page)]/section_group"></xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="section_groups/section_group"></xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
			

			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>
			<xsl:if test="$isPaginated = 'true'">
				<xsl:if test="$last_page > 1">
					<xsl:call-template name="Pagination"></xsl:call-template>
				</xsl:if>
			</xsl:if>
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- attributions -->
			<div class="attribution">
					<p class="medical_reference">
						<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
							<img>
								<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt"></xsl:value-of></xsl:attribute>
							</img>
						</xsl:if>
					</p>
				<xsl:if test="//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI'">
					<div class="nciBoxRef">
						<img class="nciBoxLogo" src="{$image_server_url}{//section_group[section_type = 'float']/section_text/table/tr/td[1]/img/@path}" alt="{//section_group[section_type = 'float']/section_text/table/tr/td[1]/img/@alt}" width="99" height="62"/>
						<div class="nciBoxLine"></div>
						<p>
							<xsl:value-of select="//section_group[section_type = 'float']/section_text/table/tr/td[3]"></xsl:value-of>
						</p>
						<div class="clearBoth"></div>
						
					</div>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
					<p class="last_updated">Last Updated: 
						<xsl:call-template name="Convert_Date">
							<xsl:with-param name="date">
								<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
					<p class="warning">
						<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
					<p class="copyright">
						<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
					</p>
				</xsl:if>
				
			</div>
			<!-- end attributions -->
		<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- END MAJOR MINI SPECIAL ETC -->
	
	
	
	
	
	
	
	
	
	
	
	<!-- BEGIN NORD TEMPLATE -->
	<xsl:template match="cons_import_health_ref[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Nord']">
		
		<div class="article">
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<!-- <div class="subhead">
					<xsl:value-of select="subheadline"/>
				</div> -->
				<!-- Begin Content Area -->
				<div class="symptomatic">
					<xsl:apply-templates select="section_groups/section_group[section_header != 'For a Complete Report']"></xsl:apply-templates>
				</div>
			</div>
			
	
			<xsl:apply-templates select="section_groups/section_group[section_header = 'For a Complete Report']"></xsl:apply-templates>
			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<!-- attributions -->
			<div class="attribution">
					<p class="medical_reference">
						<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
							<img src="{$image_server_url}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path}" alt="{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt}"/>
						</xsl:if>
					</p>
				<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
					<p class="last_updated">Last Updated: 
						<xsl:call-template name="Convert_Date">
							<xsl:with-param name="date">
								<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
					<p class="warning">
						<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
					</p>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
					<p class="copyright">
						<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
					</p>
				</xsl:if>
				
			</div>
			<!-- end attributions -->
		<div class="bottom"></div>
		</div>
	</xsl:template>
	<!-- END NORD TEMPLATE -->
	
	
	
	
	
	
	
	
	<!-- BEGIN SHC TEMPLATE -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc')]">

		<div class="article">
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="subhead"></div>
				<!-- Begin Content Area -->
				<xsl:apply-templates select="section_groups/section_group"></xsl:apply-templates>
			</div>

			<xsl:if test="//cons_topic_outline/section_groups/section_group">
				<xsl:call-template name="TopicPulldown"></xsl:call-template>
			</xsl:if>

			<div class="attribution">
					<p class="medical_reference">
						<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
						<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
							<img src="{$image_server_url}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path}" alt="{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt}"/>
						</xsl:if>
					</p>
				<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
					<div class="sources">Last Updated: 
						<xsl:call-template name="Convert_Date">
							<xsl:with-param name="date">
								<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:if>
				<xsl:if test="normalize-space(citations) != ''">
					<div class="sources">
						<div class="dropdown_wrap">
								<div class="dropdown">
									<div class="header">View Article Sources<div class="arrow_down"></div></div>
									<div class="dropdown_content">
										<xsl:apply-templates select="citations"></xsl:apply-templates>
									</div>
								</div>
							</div>
					</div>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
					<div class="sources">
						<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
					</div>
				</xsl:if>
				<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
					<p class="copyright">
						<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
					</p>
				</xsl:if>
				
			</div>
			<!-- end attributions -->
		<div class="bottom"></div>
		</div>
	</xsl:template>
	<xsl:template match="section_group[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc']">
		<div class="supportSection">
			<div class="top"></div>
			<div class="topContent">
				<span class="header">
					<xsl:value-of select="section_header"></xsl:value-of>
				</span>
			</div>
			
			<xsl:apply-templates select="section_text[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc']"></xsl:apply-templates>
		</div>
	</xsl:template>
	<xsl:template match="section_group[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc') and (section_type = 'Float')]">
		<!-- Begin Verifications Box -->
		<div class="verifiedBox">
			<div class="verifiedBoxTop"></div>
			<div class="verifiedBoxMiddle">
				<xsl:apply-templates select="section_text"></xsl:apply-templates>
			</div>
			<div class="verifiedBoxBottom"></div>
		</div>
		<!-- End Verifications Box -->
	</xsl:template>
	<xsl:template match="section_text/blockquote[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc']">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_text/blockquote/p[//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Shc']">
		<p>
			<xsl:apply-templates></xsl:apply-templates>
		</p>
		<xsl:if test="position() != last()">
			<div class="dottedline"></div>
		</xsl:if>
	</xsl:template>
	<!-- END SHC TEMPLATES -->
	
	
	
	
	
	
	
	
	
	<!-- BEGIN FRAME AND DEFINITION TEMPLATES -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Frame') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Definition')]">
		<div class="popupDefinition">
			<div class="container">
				<div class="webmdBar">
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/popupDefinition_webmd.gif" class="logoImg" width="85" height="20" border="0" alt="WebMD"/>
				</div>
				<div class="content">
					<div class="open"></div>
					<div class="middle">
						<div class="middleContent">
							<div class="scrollBox">
								<div id="textArea" class="copyNormal">
									<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
									<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
									<h3>
										<xsl:value-of select="title"></xsl:value-of>
									</h3>
									<xsl:apply-templates select="section_groups"></xsl:apply-templates>
								</div>
							</div>
						</div>
						<xsl:call-template name="general_attribution"></xsl:call-template>
					</div>
					<div class="close"></div>
				</div>
			</div>
		</div>
	</xsl:template>
	<!-- END FRAME AND DEFINITION TEMPLATES -->
	
	
	
	
	
	
	
	<!-- BEGIN MULTIMEDIA TEMPLATES -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - MultiMedia')]">
		<div class="popupDefinition">
			<div class="container">
				<div class="webmdBar">
					<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/popupDefinition_webmd.gif" class="logoImg" width="85" height="20" border="0" alt="WebMD"/>
				</div>
				<div class="content">
					<div class="open"></div>
					<div class="middle">
						<div id="middleContent">
							<div class="scrollBox">
								<div id="textArea" class="copyNormal">
									<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
									<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
									<h3>
										<xsl:value-of select="title"></xsl:value-of>
									</h3>
									<!-- font sizer -->
									<!-- end -->
									<xsl:choose>
										<xsl:when test="section_groups/section_group[1]/section_text/block.slideshow">
											<xsl:apply-templates select="section_groups/section_group[1]/section_text/block.slideshow"></xsl:apply-templates>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="section_groups/section_group[section_type!='Credits']"></xsl:apply-templates>
										</xsl:otherwise>
									</xsl:choose>
									<div class="dashed"></div>
									<div class="subheadSpaced"></div>
									<div class="credits">
										<xsl:apply-templates select="section_groups/section_group[section_type ='Credits']"></xsl:apply-templates>
									</div>
								</div>
								<!-- End Content -->
							</div>
						</div>
						<xsl:call-template name="general_attribution"></xsl:call-template>
					</div>
					<!-- end middle -->
					<div class="close"></div>
				</div>
				<!-- end content -->
			</div>
			<!-- end container -->
		</div>
	</xsl:template>
	<xsl:template match="block.slideshow">
		<xsl:element name="div">
			<xsl:attribute name="id"><xsl:text>hw_slideshow</xsl:text></xsl:attribute>
			<xsl:for-each select="slideshow.slide">
				<xsl:element name="div">
					<xsl:attribute name="class"><xsl:text>hw_slide</xsl:text></xsl:attribute>
					<xsl:attribute name="style"><xsl:choose><xsl:when test="position()=1"><xsl:text>display:block;</xsl:text></xsl:when><xsl:otherwise><xsl:text>display:none;</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:call-template name="create_slide_img">
						<xsl:with-param name="src">
							<xsl:value-of select="$image_server_url"></xsl:value-of>
							<xsl:text>/webmd/consumer_assets/site_images/media/medical/hw/</xsl:text>
							<xsl:value-of select="slide.image/@src"></xsl:value-of>
						</xsl:with-param>
						<xsl:with-param name="alt">
							<xsl:value-of select="slide.image/@alt"></xsl:value-of>
						</xsl:with-param>
						<xsl:with-param name="width">
							<xsl:value-of select="slide.image/@width"></xsl:value-of>
						</xsl:with-param>
						<xsl:with-param name="height">
							<xsl:value-of select="slide.image/@height"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:element name="h4">
						<xsl:value-of select="slide.title"></xsl:value-of>
					</xsl:element>
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>hw_slide_desc</xsl:text></xsl:attribute>
						<xsl:copy-of select="slide.description/node()"></xsl:copy-of>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>hw_ss_nav</xsl:text></xsl:attribute>
				<xsl:element name="div">
					<xsl:attribute name="id"><xsl:text>nxt_slide</xsl:text></xsl:attribute>
					<xsl:element name="a">
						<xsl:attribute name="href"></xsl:attribute>
						<xsl:attribute name="onclick"><xsl:text>return hwSlide('n');</xsl:text></xsl:attribute>
						<xsl:text>Next</xsl:text>
					</xsl:element>
				</xsl:element>
				<xsl:element name="div">
					<xsl:attribute name="id"><xsl:text>prv_slide</xsl:text></xsl:attribute>
					<xsl:element name="a">
						<xsl:attribute name="href"></xsl:attribute>
						<xsl:attribute name="onclick"><xsl:text>return hwSlide('p');</xsl:text></xsl:attribute>
						<xsl:text>Previous</xsl:text>
					</xsl:element>
				</xsl:element>
				<xsl:element name="span">
					<xsl:attribute name="id"><xsl:text>slide_num</xsl:text></xsl:attribute>
				</xsl:element>
			</xsl:element>
			<xsl:element name="script">
				<xsl:attribute name="type"><xsl:text>text/javascript</xsl:text></xsl:attribute>
				<xsl:text><![CDATA[
var allDivs = new Array();
var hwSlides = new Array();

function loadSlides() {
	allDivs = document.getElementById('hw_slideshow').getElementsByTagName('DIV');
	var index = 0
	for (i=0; i<(allDivs.length-1); i++) {
		if (allDivs[i].className == "hw_slide")
		{
			hwSlides[index] = allDivs[i];	
			index = index + 1;
		}
	}
	
	var temp = document.getElementById("nxt_slide");
	
	document.getElementById('slide_num').innerHTML = "Slide 1 of " + (hwSlides.length);	
	document.getElementById("prv_slide").innerHTML = "<a class=\"disabled\" href=\"#\" onclick=\"\"> Previous </a>";
	
}
function hwSlide(direct) {
	for (i=0; i<(hwSlides.length); i++) {	
		if (hwSlides[i].style.display == "block") {
			var curSlide = i;
		}
	}
	document.getElementById("nxt_slide").innerHTML = "<a class=\"\" href=\"\" onclick=\"return hwSlide('n');\"> Next </a>";
	document.getElementById("prv_slide").innerHTML = "<a class=\"\" href=\"\" onclick=\"return hwSlide('p');\"> Previous </a>";
	
	hwSlides[curSlide].style.display = "none";
	if (direct == "n") {
		newSlide = curSlide+1;
	}
	else if (direct == "p") {
		newSlide = curSlide-1;
	}
	hwSlides[newSlide].style.display = "block";
	if (newSlide == (hwSlides.length-1)) {
		document.getElementById("nxt_slide").innerHTML = "<a class=\"disabled\" href=\"#\" onclick=\"\"> Next </a>";
	}
	else if (newSlide == 0) {
		document.getElementById("prv_slide").innerHTML = "<a class=\"disabled\" href=\"#\" onclick=\"\"> Previous </a>";
	}
	document.getElementById('slide_num').innerHTML = "Slide " + (newSlide + 1) + " of " + (hwSlides.length);
	return false;
}

]]></xsl:text>
			</xsl:element>
			<xsl:element name="script">
				<xsl:attribute name="type"><xsl:text>text/javascript</xsl:text></xsl:attribute>
				<xsl:text>loadSlides();</xsl:text>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template name="create_slide_img">
		<xsl:param name="src"></xsl:param>
		<xsl:param name="alt"></xsl:param>
		<xsl:param name="width"></xsl:param>
		<xsl:param name="height"></xsl:param>
		<img border="0" src="{$src}" alt="{$alt}" width="{$width}" height="{$height}"/>
	</xsl:template>
	<xsl:template match="section_text[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - MultiMedia')]">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>

	<xsl:template match="param[@name='movie']">
		<xsl:variable name="prefix">
			<xsl:if test="substring(@value,1,6) != '/webmd'">/webmd</xsl:if>
		</xsl:variable>
		<param value="{$image_server_url}{$prefix}{@value}">
			<xsl:copy-of select="@*[name() != 'value']"></xsl:copy-of>
		</param>
	</xsl:template>
	<!-- END MULTIMEDIA TEMPLATES -->
	<xsl:template match="section_group">
		<xsl:apply-templates select="section_header"></xsl:apply-templates>
		<xsl:apply-templates select="section_text"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_group[(section_type = 'Credits') and (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - MultiMedia')]">


		<xsl:apply-templates select="section_text"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section_group[section_header = 'For a Complete Report']">
		<!-- Begin Verifications Box -->
		<div class="verifiedBox">
			<div class="verifiedBoxTop_lt"></div>
			<div class="verifiedBoxMiddle_lt">
				<h2>
					<xsl:value-of select="section_header"></xsl:value-of>:
				</h2>
				<xsl:apply-templates select="section_text" mode="nord"></xsl:apply-templates>
				<div class="dottedline"></div>
			</div>
			<div class="verifiedBoxMiddle_symptomatic">
				<xsl:apply-templates select="section_text/blockquote"></xsl:apply-templates>
			</div>
			<div class="verifiedBoxBottom"></div>
		</div>
		<!-- End Verifications Box -->
	</xsl:template>
	
	
	
	
	
	
	
	
	
	<!-- BEGIN SYMPTOM CHECK TEMPLATES -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name ='Healthwise - Symptom') and (//cons_import_health_ref/pages/page[1]/section_group[1]/section_type = 'CheckYourSymptoms')]">
		

		<script src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/javascript/actionset.js"></script>
		<div class="HW_checkSymptoms">
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="moduleSpacer"></div>
				<div id="head">
					<div id="step1_head">
						<div id="step1_blurb">
							<xsl:apply-templates select="pages/page[1]/section_group/section_text/p[position() &lt; 3]"></xsl:apply-templates>
						</div>
					</div>
					<div id="step2_head" style="display:none;">
						<xsl:apply-templates select="pages/page[1]/section_group/section_text/cys.questions" mode="head"></xsl:apply-templates>
					</div>
					<div id="step3_head" style="display:none;">
						<div id="step3_blurb"></div>
					</div>
				</div>
				<!-- end Top -->
				<!-- Start Content -->
				<div class="tabLevel">
					<div id="step1Tab" class="tab1">Step One</div>
					<div id="step1TabB" class="tab1" style="display:none;">
						<a href="#" onclick="javascript:controlSymptomTabs('step1');">Step One</a>
					</div>
					<div></div>
					<div id="step2Tab" class="tabGray">Step Two</div>
					<div id="step2TabB" class="tab" style="display:none;">
						<a href="#" onclick="javascript:controlSymptomTabs('step2');">Step Two</a>
					</div>
					<div></div>
					<div id="step3Tab" class="tabGray">Step Three</div>
				</div>
				<!-- STEP 1 -->
				<xsl:apply-templates select="pages/page[1]/section_group/section_text/cys.questions"></xsl:apply-templates>
				<!-- STEP 2 -->
				<div id="step2" class="fontDefault" style="display:none;">
					<xsl:apply-templates select="pages/page[1]/section_group/section_text/cys.questions" mode="step2"></xsl:apply-templates>
				</div>
				<!--STEP 3 -->
				<div id="step3" class="fontDefault" style="display:none;">
					<div id="s1" style="display:none">
						<div class="boundingBox">
							<!-- Start Step 3 -->
							<div class="highlightBox">
								<div class="iconTitle">
									<div class="icon">
										<img src="{$image_server_url}/webmd/consumer_assets/site_images/media/interface/red.gif" width="20" height="20" alt="Call Immediately"/>
									</div>
									<div class="instructions">Call your health professional immediately.</div>
								</div><p>You have answered "Yes" to a question that indicates you may need immediate care. Call your health professional now to discuss your symptoms and arrange for your care.</p>
								<ul>
									<li>Symptoms are likely to worsen without medical care.</li>
									<li>If you do not have a health professional, seek emergency care.</li>
									<li>Emergency transportation is not needed. However, if you are not able to travel safely either by driving yourself or having someone else drive you, call an ambulance.</li>
								</ul>
								<p>You do not need to answer any of the other questions.</p>
								<div class="dashed"></div>
								<div class="space"></div>
								<div class="wmdButton">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr class="t">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
										<tr class="c">
											<td class="l"></td>
											<td class="m">
												<a href="http://doctor.webmd.com/physician_finder/home.aspx?sponsor=core" onclick="return sl(this,'','embd-lnk');">physician directory</a>
											</td>
											<td class="r"></td>
										</tr>
										<tr class="b">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- End Highlight Box -->
						</div>
						<!-- End Bounding Box Box -->
					</div>
					<div id="s2" style="display:none">
						<div class="boundingBox">
							<!-- Start Step 3 -->
							<div class="highlightBox">
								<div class="iconTitle">
									<div class="icon">
										<img src="{$image_server_url}/webmd/consumer_assets/site_images/media/interface/yellow.gif" width="20" height="20" alt="Call Today"/>
									</div>
									<div class="instructions">Call your health professional today.</div>
								</div><p>You have answered "Yes" to a question that indicates you need to call your health professional to discuss your symptoms and arrange for care.</p>
								<ul>
									<li>An appointment today is usually needed.</li>
									<li>Symptoms are unlikely to improve without medical care.</li>
								</ul>
								<p>Return to the Check Your Symptoms section and answer the questions.  You may need to see a health professional sooner if you have other more serious symptoms.</p>
								<div class="dashed"></div>
								<div class="space"></div>
								<div class="wmdButton">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr class="t">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
										<tr class="c">
											<td class="l"></td>
											<td class="m">
												<a href="http://doctor.webmd.com/physician_finder/home.aspx?sponsor=core" onclick="return sl(this,'','embd-lnk');">physician directory</a>
											</td>
											<td class="r"></td>
										</tr>
										<tr class="b">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- End Highlight Box -->
						</div>
						<!-- End Bounding Box Box -->
					</div>
					<div id="s3" style="display:none">
						<div class="boundingBox">
							<!-- Start Step 3 -->
							<div class="highlightBox">
								<div class="iconTitle">
									<div class="icon">
										<img src="{$image_server_url}/webmd/consumer_assets/site_images/media/interface/green.gif" width="20" height="20" alt="Wait"/>
									</div>
									<div class="instructions">You may wait to see if the symptoms improve over the next 24 hours.</div>
								</div><p>You have answered "Yes" to a question that indicates you may wait to see if your symptoms improve over the next 24 hours (or the specified time period). If symptoms improve, no appointment is needed.</p>
								<ul>
									<li>If symptoms do not improve after 24 hours (or the specified time period), an appointment within the next 24 hours is usually needed.</li>
									<li>If appropriate, try home treatment to relieve your symptoms.</li>
									<li>Check your symptoms in 24 hours, or sooner if there is any change.</li>
									<li>Call your health professional if symptoms get worse.</li>
								</ul>
								<p>Return to the Check Your Symptoms section and answer the questions.  You may need to see a health professional sooner if you have other more serious symptoms.</p>
								<div class="dashed"></div>
								<div class="space"></div>
								<div class="wmdButton">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr class="t">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
										<tr class="c">
											<td class="l"></td>
											<td class="m">
												<a href="http://doctor.webmd.com/physician_finder/home.aspx?sponsor=core" onclick="return sl(this,'','embd-lnk');">physician directory</a>
											</td>
											<td class="r"></td>
										</tr>
										<tr class="b">
											<td class="l"></td>
											<td class="m"></td>
											<td class="r"></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- End Highlight Box -->
						</div>
						<!-- End Bounding Box Box -->
					</div>
					<div class="moduleSpacer"></div>
				</div>
			</div>
			<xsl:if test="pages/page[1]/section_group/section_text/cys.questions/following-sibling::h3">
				<div class="moduleSpacer"></div>
				<div class="subheaderBar">
					<xsl:value-of select="pages/page[1]/section_group/section_text/cys.questions/following-sibling::h3"></xsl:value-of>
				</div>
				<div class="moduleSpacer"></div>
				<!-- links module -->
				<div class="articleLinks">
					<p class="articleLinkstopQuestion">
						<xsl:value-of select="pages/page[1]/section_group/section_text/cys.questions/following-sibling::p[position() = 1]"></xsl:value-of>
					</p>
					<xsl:apply-templates select="pages/page[1]/section_group/section_text/cys.questions/following-sibling::ul"></xsl:apply-templates>
				</div>
				<!-- end links module -->
				<div class="mainContentSectionFooter"></div>
			</xsl:if>
			<div class="selfCare">
				<xsl:apply-templates select="pages/page[1]/section_group/section_text/p[position() = last()]"></xsl:apply-templates>
			</div>
		</div>

		<xsl:if test="//cons_topic_outline/section_groups/section_group">
			<xsl:call-template name="TopicPulldown"></xsl:call-template>
		</xsl:if>

		<xsl:call-template name="general_attribution"></xsl:call-template>
	</xsl:template>
	<xsl:template match="cys.questions">
		<div id="step1" class="fontDefault">
			<div class="boundingBox">
				<!-- Start Step 1 -->
				<div class="highlightBox">
					<xsl:apply-templates select="//pages/page[1]/section_group/section_text/*[(preceding-sibling::p[position()=2]) and (following-sibling::cys.questions)]"></xsl:apply-templates>
					<xsl:apply-templates select="cys.question" mode="step1"></xsl:apply-templates>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="cys.questions" mode="step2">
		<xsl:apply-templates select="cys.question" mode="step2"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="cys.questions" mode="head">
		<xsl:apply-templates select="cys.question" mode="head"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="cys.question" mode="step1">
		<div class="dashed"></div>
		<div class="rightButton">
			<div class="wmdButton">
				<table cellpadding="0" cellspacing="0" border="0">
					<tbody>
						<tr class="t">
							<td class="l"></td>
							<td class="m"></td>
							<td class="r"></td>
						</tr>
						<tr class="c">
							<td class="l"></td>
							<td class="m">
								<a href="javascript:advanceNextStep('step2','step2','qu_{position()}','step2_head','step2_qu{position()}_blurb');">Yes</a>
							</td>
							<td class="r"></td>
						</tr>
						<tr class="b">
							<td class="l"></td>
							<td class="m"></td>
							<td class="r"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<p class="symptomQuestion">
			<xsl:value-of select="normalize-space(question.text)"></xsl:value-of>
		</p>
	</xsl:template>
	<xsl:template match="cys.question" mode="step2">
		<xsl:apply-templates select="cys.when-to-see/cys.severity-groups">
			<xsl:with-param name="qu" select="position()"></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="cys.question" mode="head">
		<div id="step2_q{position()}_blurb" style="display:none;">
			<xsl:apply-templates select="cys.when-to-see/p[position() &lt; 3]"></xsl:apply-templates>
		</div>
	</xsl:template>
	<xsl:template match="cys.severity-groups">
		<xsl:param name="qu"></xsl:param>
		<div id="qu_{$qu}">
			<div class="boundingBox">
				<!-- Start Step 2 -->
				<div class="highlightBox">
					<xsl:apply-templates select="cys.severity-group">
						<xsl:with-param name="qu" select="$qu"></xsl:with-param>
					</xsl:apply-templates>
					<xsl:apply-templates select="following-sibling::node()"></xsl:apply-templates>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="cys.severity-group">
		<xsl:param name="qu"></xsl:param>
		<xsl:apply-templates select="severity.questions/severity.question">
			<xsl:with-param name="sev" select="@severity"></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="severity.questions"></xsl:template>
	<xsl:template match="severity.question">
		<xsl:param name="sev"></xsl:param>
		<div class="rightButton">
			<div class="wmdButton">
				<table cellpadding="0" cellspacing="0" border="0">
					<tbody>
						<tr class="t">
							<td class="l"></td>
							<td class="m"></td>
							<td class="r"></td>
						</tr>
						<tr class="c">
							<td class="l"></td>
							<td class="m">
								<a href="javascript:advanceNextStep('step3','step3','{$sev}', 'step3_head','step3_blurb');">Yes</a>
							</td>
							<td class="r"></td>
						</tr>
						<tr class="b">
							<td class="l"></td>
							<td class="m"></td>
							<td class="r"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<p class="symptomQuestion">
			<xsl:value-of select="normalize-space(question.text)"></xsl:value-of>
		</p>
		<div class="dashed"></div>
	</xsl:template>
	<!-- END SYMPTOM CHECK TEMPLATES -->
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- BEGIN HW EMERGENCY TEMPLATES -->
	<xsl:template match="cons_import_health_ref[(//metadata_section/wbmd_publ/wbmd_publ_name ='Healthwise - Symptom') and (//cons_import_health_ref/pages/page[1]/section_group[1]/section_type = 'Emergency')]">

		<script src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/javascript/actionset.js"></script>
		<div class="HW_emergency">
			<div id="textArea" class="copyNormal">
				<!-- *** commented out for mobile in case we want to put it back ***<xsl:call-template name="share_bar"></xsl:call-template>-->
				<!-- *** commented out for mobile in case we want to put it back *** <xsl:call-template name="font_sizer"></xsl:call-template>-->
				<h2>
					<xsl:value-of select="title"></xsl:value-of>
				</h2>
				<div class="moduleSpacer"></div>
				<div class="tabLevel">
					<div id="step1Tab" class="tab">Step One</div>
					<div id="step1TabB" class="tab" style="display:none;">
						<a href="javascript:toggleALL_HW_emergency();javascript:toggle('step1');javascript:setClassName('step2Tab', 'tabGray');javascript:toggle('step1Tab');javascript:toggle('step1TabB');">Step One</a>
					</div>
					<div id="step2Tab" class="tabGray">Step Two</div>
				</div>
				<div id="step1" class="fontDefault">
					<div class="boundingBox">
						<!-- Start Step 1 -->
						<div class="highlightBox">
							<a href="javascript:setClassName('step2Tab', 'tab');javascript:toggle('step1');javascript:toggle('step2');javascript:toggle('step1Tab');javascript:toggle('step1TabB');">
								<img src="{$image_server_url}/webmd/consumer_assets/site_images/modules/HW_emergencyRedYes.jpg" border="0" width="48" height="21" alt="yes"/>
							</a>
							<xsl:apply-templates select="pages/page[1]/section_group/section_text/question.text/node()"></xsl:apply-templates>
							<xsl:apply-templates select="pages/page[1]/section_group/section_text/blockquote/ul" mode="Emergency"></xsl:apply-templates>


						</div>
					</div>
				</div>
				<div id="step2" class="fontDefault" style="display:none;">
					<div class="boundingBox">
						<!-- Start Step 2 -->
						<div class="highlightBox">
							<div class="space"></div>
							<div class="lineHeight1">
								<p>You have answered "Yes" to the question that indicates you need emergency care.</p>
								<p>
									<b>Call 
										<span class="red">911</span> or other emergency services immediately.
									</b>
								</p>
							</div>
							<div class="space"></div>
						</div>
						<!-- End Highlight Box -->
					</div>
					<!-- End Step 2 -->
				</div>
			</div>
		</div>

		<!-- end HW_emergency-->
		<xsl:if test="//cons_topic_outline/section_groups/section_group">
			<xsl:call-template name="TopicPulldown"></xsl:call-template>
		</xsl:if>
		
		<xsl:call-template name="general_attribution"></xsl:call-template>
	</xsl:template>
	<xsl:template match="inline.emer-num">
		<xsl:text></xsl:text>
		<span class="red">911</span>
		<xsl:text></xsl:text>
	</xsl:template>
	<xsl:template match="blockquote/ul" mode="Emergency">
		<div class="dashed"></div>
		<ul>
			<xsl:apply-templates mode="Emergency"></xsl:apply-templates>
		</ul>
	</xsl:template>
	<xsl:template match="*" mode="Emergency">
		<xsl:copy>
			<xsl:copy-of select="@*"></xsl:copy-of>
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="li[ul]" mode="Emergency">
		<li>
			<xsl:apply-templates select="node()"></xsl:apply-templates>
		</li>
		<li class="nestedList">
			<xsl:apply-templates mode="Emergency"></xsl:apply-templates>
		</li>
		<div class="dashed"></div>
	</xsl:template>
	<xsl:template match="ul[parent::li]" mode="Emergency">
		<ul class="innerList">
			<xsl:apply-templates mode="Emergency"></xsl:apply-templates>
		</ul>
	</xsl:template>
	<xsl:template match="li[parent::ul/parent::li]" mode="Emergency">
		<li>
			<span class="innerBullet">&#8226;</span>
			<xsl:apply-templates></xsl:apply-templates>
		</li>
	</xsl:template>
	<xsl:template match="li[parent::ul/parent::blockquote]" mode="Emergency">
		<li>
			<xsl:apply-templates mode="Emergency"></xsl:apply-templates>
		</li>
		<div class="dashed"></div>
	</xsl:template>
	
	<xsl:template match="a" mode="Emergency">
		<xsl:variable name="furl">
			<xsl:call-template name="GetURLRef">
				<xsl:with-param name="ObjectID">
					<xsl:value-of select="@chronic_id"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$furl !=''">
				<a href="{$furl}">
					<xsl:attribute name="onclick">return sl(this,'','embd-lnk');</xsl:attribute>
					<xsl:apply-templates></xsl:apply-templates>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates></xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END HW EMERGENCY TEMPLATES -->
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- *** No related links on Mobile, but leaving this in just in case it gets referenced somewhere *** -->
	<!--
	<xsl:template match="//related_links_text">
	</xsl:template>
	-->
	

	<xsl:template name="CreateFirstAidRelated">
		<!-- *** No related links on Mobile, but leaving this in just in case it gets referenced somewhere *** -->
	</xsl:template>
	

	<xsl:template name="Pagination_new">
		<xsl:text disable-output-escaping="yes"><![CDATA[<script type="text/javascript">webmd.debug('Currently Running OTT test: ott_short-page_versiona in this Node');</script>]]></xsl:text>
		<xsl:variable name="new_last_page">
			<xsl:value-of select="ceiling(count(/webmd_rendition/content/wbmd_asset/content_section/*/pages/page/section_group) div number($sections_per_page))"></xsl:value-of>
		</xsl:variable>
		<xsl:variable name="page_prefix">
			<xsl:choose>
				<xsl:when test="$prefix">
					<xsl:value-of select="$prefix"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@prefix"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<!-- pagination -->
			<div class="pagination">	
					
						<xsl:choose>
							<xsl:when test="$current_page = 1"></xsl:when>
							<xsl:when test="$current_page - 1 = 1">
								<div class="previous"><div class="arrow">
									<a href="http://{$page_prefix}.{$domain}{$pg_furl}" class="arrow_left">Previous</a>
								</div></div>
							</xsl:when>
							<xsl:otherwise>
								<div class="previous"><div class="arrow">
									<a class="arrow_left"><xsl:attribute name="href">?page=<xsl:value-of select="$current_page - 1"></xsl:value-of></xsl:attribute>&lt; Previous</a>
								</div></div>
							</xsl:otherwise>
						</xsl:choose>
					
					
					<div class="page_num">
						<xsl:for-each select="/webmd_rendition/content/wbmd_asset/content_section/*/pages/page/section_group">
							<xsl:if test="position() mod number($sections_per_page) = 0">
								<xsl:variable name="page_iterator">
									<xsl:value-of select="ceiling(position() div number($sections_per_page))"></xsl:value-of>
								</xsl:variable>
							<xsl:choose>
									<xsl:when test="$page_iterator = $current_page">
									<span class="current">
										<xsl:value-of select="position()"></xsl:value-of>
									</span>
								</xsl:when>
									<xsl:when test="($page_iterator != $current_page) and ($page_iterator = 1)">
									<a href="http://{/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@prefix}.{$domain}{/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@friendlyurl}">1</a>
								</xsl:when>
								<xsl:otherwise>
									<a>
											<xsl:attribute name="href">?page=<xsl:value-of select="$page_iterator"></xsl:value-of></xsl:attribute>
											<xsl:value-of select="$page_iterator"></xsl:value-of>
									</a>
								</xsl:otherwise>
							</xsl:choose>
								<xsl:if test="$page_iterator != $new_last_page">
									<span class="pipe_fmt"> | </span>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</div>
					
						<xsl:choose>
							<xsl:when test="$current_page = $new_last_page">
							</xsl:when>
							<xsl:otherwise>
								<div class="next">
									<div class="arrow">
									<a class="arrow_right">
										<xsl:attribute name="href">?page=<xsl:value-of select="$current_page + 1"></xsl:value-of></xsl:attribute>Next</a>
									</div>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					
					
					
				<div class="clearing"></div>
			</div>
	</xsl:template>
	<!-- PAGINATION TEMPLATE -->
	<xsl:template name="Pagination">
		<xsl:variable name="page_prefix">
			<xsl:choose>
				<xsl:when test="$prefix">
					<xsl:value-of select="$prefix"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@prefix"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<!-- pagination -->
			<div class="pagination">	
					
						<xsl:choose>
							<xsl:when test="$current_page = 1"></xsl:when>
							<xsl:when test="$current_page - 1 = 1">
								<div class="previous"><div class="arrow">
									<a href="http://{$page_prefix}.{$domain}{$pg_furl}" class="arrow_left">Previous</a>
								</div></div>
							</xsl:when>
							<xsl:otherwise>
								<div class="previous"><div class="arrow">
									<a class="arrow_left"><xsl:attribute name="href">?page=<xsl:value-of select="$current_page - 1"></xsl:value-of></xsl:attribute>&lt; Previous</a>
								</div></div>
							</xsl:otherwise>
						</xsl:choose>
					
					
					<div class="page_num">
						<xsl:for-each select="//pages/page">
							<xsl:choose>
								<xsl:when test="position()=$current_page">
									<span class="current">
										<xsl:value-of select="position()"></xsl:value-of>
									</span>
								</xsl:when>
								<xsl:when test="(position() != $current_page) and (position() = 1)">
									<a href="http://{/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@prefix}.{$domain}{/webmd_rendition/friendlyurls/target[@siteid = $site_id]/@friendlyurl}">1</a>
								</xsl:when>
								<xsl:otherwise>
									<a>
										<xsl:attribute name="href">?page=<xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
										<xsl:attribute name="title">Page <xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
										<xsl:value-of select="position()"></xsl:value-of>
									</a>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="position() != last()">
								<span class="pipe"> | </span>
							</xsl:if>
						</xsl:for-each>
					</div>
					
						<xsl:choose>
							<xsl:when test="$current_page = $last_page">
							</xsl:when>
							<xsl:otherwise>
								<div class="next">
									<div class="arrow">
									<a class="arrow_right">
										<xsl:attribute name="href">?page=<xsl:value-of select="$current_page + 1"></xsl:value-of></xsl:attribute>Next</a>
									</div>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					
					
					
				<div class="clearing"></div>
			</div>

	</xsl:template>
	<!--  END PAGINATION TEMPLATE -->
	
	
	
	
	<!-- FOR FAQ -->
	<xsl:template match="question_and_answer_group" mode="multi">
		<li class="question">
			<a href="" onclick="toggleFAQ(this);blur(this); return false;">
				<xsl:value-of select="question"></xsl:value-of>
			</a>
		</li>
		<li class="answer">
			<div class="answerBox">
				<div class="Top"></div>
				<div class="Content">
					<div class="ContentPad">
						<h4>Answer:</h4>
						<p>
							<xsl:apply-templates select="answer_section_groups/answer/section_text"></xsl:apply-templates>
						</p>
						<div class="close">
							<a href="" onclick="closeFAQ(); return false;">Close</a>
						</div>
					</div>
				</div>
				
			</div>
		</li>
	</xsl:template>
	
	<!-- FOR FAQ -->
	<xsl:template match="question_and_answer_group" mode="single">
		<h3>Question:</h3>
		<br/>
		<xsl:apply-templates select="question"></xsl:apply-templates>
		<div class="answerBox">
			<div class="Top"></div>
			<div class="Content">
				<div class="ContentPad">
					<h4>Answer:</h4>
					<xsl:apply-templates select="answer_section_groups/answer/section_text"></xsl:apply-templates>
				</div>
			</div>
			
		</div>
	</xsl:template>
	<xsl:template match="question">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	
	
	
	<xsl:template match="section_group">
		<h3>
			<xsl:value-of select="section_header"></xsl:value-of>
		</h3>
		<xsl:apply-templates select="section_text"></xsl:apply-templates>
	</xsl:template>
	
	
	
	<xsl:template match="section_text">
		<!--Insert the thumbnail in all criteria are met:
- Current Page is 1
- The thumnail path is specified
- This is the first section_group on the page
- This is a news template
- if the path is not webmdNone
-->
		<xsl:if test="$current_page=1 and position()=1 and /webmd_rendition/content/wbmd_asset/metadata_section/wbmd_c_art_thmbnl/@path != '' and not(parent::section_group/preceding-sibling::section_group) and parent::section_group/parent::page/parent::pages/parent::cons_news and /webmd_rendition/content/wbmd_asset/metadata_section/wbmd_c_art_thmbnl/@path != '/webmdNone'">
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>art_thumb</xsl:text></xsl:attribute>
				<xsl:call-template name="GetImg">
					<xsl:with-param name="src">
						<xsl:value-of select="$image_server_url"></xsl:value-of>
						<xsl:value-of select="/webmd_rendition/content/wbmd_asset/metadata_section/wbmd_c_art_thmbnl/@path"></xsl:value-of>
					</xsl:with-param>
					<xsl:with-param name="alt">
						<xsl:value-of select="/webmd_rendition/content/wbmd_asset/metadata_section/wbmd_c_art_thmbnl/@wbmd_c_alt_tag"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</xsl:if>
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	
	
	
	<xsl:template match="section_group[section_type = 'HealthTools']">
		<xsl:if test="count(preceding-sibling::section_group) > 0">
			<h3>
				<xsl:value-of select="section_header"></xsl:value-of>
			</h3>
		</xsl:if>
		<p class="spaced">
			<xsl:value-of select="section_text/p[1]"></xsl:value-of>
		</p>
		<xsl:apply-templates select="section_text/table/tr" mode="HT"></xsl:apply-templates>
	</xsl:template>
	
	
	
	<xsl:template match="tr" mode="HT">
		<xsl:choose>
			<xsl:when test="td[1]/@valign='top'">
				<div class="subheadSpaced">
					<xsl:apply-templates select="td[1]/img"></xsl:apply-templates>
					<!-- <xsl:value-of select="section_text/table/tr[2]/td[2]/a"/>  -->
				</div>
				<p class="spaced">
					<xsl:apply-templates select="td[2]/child::node()"></xsl:apply-templates>
				</p>
			</xsl:when>
			<xsl:when test="td[1]/@colspan='2'"></xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="td[2]/a">
					<xsl:variable name="furl">
						<xsl:call-template name="GetURLRef">
							<xsl:with-param name="ObjectID">
								<xsl:value-of select="@chronic_id"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="$furl !=''">
							<a href="{$furl}" onclick="return sl(this,'','embd-lnk');" class="fakeUl">
								<xsl:apply-templates></xsl:apply-templates>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<span class="fakeUl">
								<xsl:apply-templates></xsl:apply-templates>
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="section_group[(section_type = 'float') and (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI')]"></xsl:template>
	
	
	<xsl:template match="blockquote/div/p[/webmd_asset/metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI']" mode="NCI_BQ">
		<xsl:copy>
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:copy>
		<xsl:choose>
			<xsl:when test="position() = last()">
				<div class="verifiedBoxBottomSpacer"></div>
			</xsl:when>
			<xsl:otherwise>
				<div class="dottedline"></div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="section_text" mode="nord">
		<xsl:apply-templates select="*[not(self::blockquote)]"></xsl:apply-templates>
	</xsl:template>
	
	
	<xsl:template match="section_text/blockquote[/webmd_asset/metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - NCI']">
		<xsl:apply-templates select="div/p" mode="NCI_BQ"></xsl:apply-templates>
	</xsl:template>
	
	
	<xsl:template name="attributions_cp">
		<!-- Begin Attributions -->
		<div class="attribution">
			<p class="medical_reference">
					<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_pub_display"></xsl:value-of>
					<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_company/wbmd_bus_comp_nm"></xsl:value-of>
					<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_company/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_company/wbmd_bus_logo/@path"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_company/wbmd_bus_logo/@alt"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt"></xsl:value-of></xsl:attribute>
						</img>
					</xsl:if>
				</p>
			<xsl:if test="//metadata_section/wbmd_copyright/wbmd_copyright_statement">
				<p class="copyright">
					<xsl:value-of select="//metadata_section/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
				</p>
			</xsl:if>
			
		</div>
		<!-- end attributions -->
	</xsl:template>
	
	
	
	<xsl:template name="faq_attribution">
		<div class="attribution">
			<p class="medical_reference">
					<xsl:value-of select="//wbmd_publ/wbmd_publ_display"></xsl:value-of>
					<br/>
					<xsl:value-of select="//wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_comp_nm"></xsl:value-of>
					<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
						<img src="{$image_server_url}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path}" border="0" alt="{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt}{//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt}"/>
					</xsl:if>
				</p>
			<xsl:if test="string(//cons_faq/citations)">
				<div class="sources">
					<div class="dropdown_wrap">
							<div class="dropdown">
								<div class="header">View Article Sources<div class="arrow_down"></div></div>
								<div class="dropdown_content">
									<xsl:apply-templates select="citations"></xsl:apply-templates>
								</div>
							</div>
						</div>
				</div>
			</xsl:if>
			<xsl:call-template name="ReviewedByOnText"></xsl:call-template>
			<xsl:call-template name="EditedByOnText"></xsl:call-template>
			<xsl:if test="//wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
				<p class="warning">
					<xsl:value-of select="//wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
				</p>
			</xsl:if>
			<xsl:if test="//wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
				<p class="copyright">
					<xsl:value-of select="//wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
				</p>
			</xsl:if>
			
		</div>
	</xsl:template>
	
	
	
	
	<xsl:template name="general_attribution">
		<div class="attribution">
			<p class="medical_reference">
					<xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_display"></xsl:value-of>
					<xsl:if test="(//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path !='') or (//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path !='')">
						<img>
							<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@path"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@path"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_bus_logo/@alt"></xsl:value-of><xsl:value-of select="//metadata_section/wbmd_publ/wbmd_publ_bus_entity/wbmd_dept_logo/@alt"></xsl:value-of></xsl:attribute>
						</img>
					</xsl:if>
				</p>
			<xsl:if test="//metadata_section/wbmd_orig_pub_dt">
				<p class="last_updated">Last Updated: 
					<xsl:call-template name="Convert_Date">
						<xsl:with-param name="date">
							<xsl:value-of select="//metadata_section/wbmd_orig_pub_dt"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>

				</p>
			</xsl:if>
			<xsl:if test="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement">
				<p class="warning">
					<xsl:value-of select="//metadata_section/wbmd_disclmr/wbmd_disclaimer/disclaimer_statement"></xsl:value-of>
				</p>
			</xsl:if>
			<xsl:if test="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement">
				<p class="copyright">
					<xsl:value-of select="//metadata_section/wbmd_cpyrt/wbmd_copyright/wbmd_copyright_statement"></xsl:value-of>
				</p>
			</xsl:if>
			
		</div>
	</xsl:template>
	
	
	
	
	
	<!--   TOPIC GUIDE TEMPLATES -->
	<xsl:template name="TopicPulldown">
		<div class="articlesPulldown">
			<form onsubmit="return submitNavForm(externalUrlList,'NextTopicPulldown',true)" style="padding-top:5px;">
					Next Article:
				<select name="next_pulldown" id="NextTopicPulldown" class="pulldown">
					<xsl:apply-templates select="//cons_topic_outline/section_groups/section_group"></xsl:apply-templates>
				</select>
				<input name="submit" value="Go" alt="Go" align="top" src="http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/modules/articlePulldownGoBtn.gif" type="image"/>>
      </form>
		</div>
		<script type="text/javascript" language="JavaScript">
				selectNextArticle('NextTopicPulldown',s_furl);
		</script>
	</xsl:template>

	
	<xsl:template match="cons_topic_outline/section_groups/section_group">
		<option>
			<xsl:variable name="furl">
				<xsl:call-template name="GetURLRef">
					<xsl:with-param name="ObjectID">
						<xsl:value-of select="section_link/@chronic_id"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:attribute name="value"><xsl:choose><xsl:when test="$furl !=''"><xsl:value-of select="$furl"></xsl:value-of></xsl:when><xsl:otherwise>#</xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:value-of select="section_title"></xsl:value-of>
		</option>
	</xsl:template>
	<!-- END TOPIC GUIDE TEMPLATES -->
	


	<xsl:template name="GuideFeedback">
		<!-- *** no code in here for mobile, will put back if we want to ask for feedback *** -->
	</xsl:template>
	<!-- END GUIDE TEMPLATE -->
	
	
	
	
	
	
	<!-- BEGIN MULTIMEDIA TEMPLATES -->
	<xsl:template match="section_groups[(//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Frame') or (//metadata_section/wbmd_publ/wbmd_publ_name = 'Healthwise - Definition')]">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<!-- end multimedia templates -->
	
	
	
	
	
	<xsl:template name="share_bar">
		<!-- *** commenting this out for mobile for right now as we don't have plans for a share bar, but might later *** -->
	</xsl:template>
	
	
	
	<xsl:template name="font_sizer">
		<!-- *** commenting this out for mobile for right now as we don't have plans for a font sizer now, but might later *** -->
	</xsl:template>
	
	
	
	<xsl:template match="*">
		<xsl:element name="{translate(local-name(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
			<xsl:copy-of select="@*"></xsl:copy-of>
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	
	
	
	<xsl:template match="section_group[1]/section_text/p[2]">
		<xsl:copy>
			<xsl:copy-of select="@*"></xsl:copy-of>
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="ImageMaker">
		<xsl:param name="class"></xsl:param>
		<xsl:param name="src"></xsl:param>
		<xsl:param name="alt"></xsl:param>
		<img class="{$class}" src="{$src}" alt="{$alt}"/>
	</xsl:template>
	<xsl:template name="GetURLRefExpanded">
		<xsl:param name="ObjectID"></xsl:param>
		<xsl:if test="(//referenced_objects_expanded/object[@chronic_id=$ObjectID and @pointer='0']/target[@siteid=$site_id]/@friendlyurl) or (//referenced_objects_expanded/object[@chronic_id=$ObjectID and @pointer='1']/target/@friendlyurl)">
			<xsl:choose>
				<xsl:when test="//referenced_objects_expanded/object[@chronic_id=$ObjectID]//@pointer = '1'">
					<xsl:value-of select="//referenced_objects_expanded/object[@chronic_id=$ObjectID][1]/target/@friendlyurl"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>http://<xsl:value-of select="//referenced_objects_expanded/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@prefix[1]"></xsl:value-of>.<xsl:value-of select="$domain"></xsl:value-of>
					<xsl:value-of select="//referenced_objects_expanded/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@friendlyurl[1]"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	
	
	
	<xsl:template match="a|A">
		<xsl:value-of select="."></xsl:value-of>
	</xsl:template>
	
	
	<xsl:template match="img|IMG">
		<img border="0">
			<xsl:attribute name="src"><xsl:value-of select="$image_server_url"></xsl:value-of><xsl:value-of select="@path"></xsl:value-of></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="@alt"></xsl:value-of></xsl:attribute>
			<xsl:attribute name="align"><xsl:value-of select="@align"></xsl:value-of></xsl:attribute>
			<xsl:attribute name="style"><xsl:value-of select="@style"></xsl:value-of></xsl:attribute>
		</img>
	</xsl:template>
	
	
	<xsl:template match="hr|HR"></xsl:template>
	
	
	<xsl:template match="inline.measurement">
		<xsl:value-of select="@initval"></xsl:value-of>
		<xsl:text></xsl:text>
		<xsl:value-of select="@unit1"></xsl:value-of>
	</xsl:template>
	
	<!--   DATE CONVERSION TEMPLATES -->
	<xsl:template name="Convert_Date">
		<xsl:param name="date"></xsl:param>
		<xsl:if test="$date != 'nulldate'">
			<xsl:choose>
				<xsl:when test="string-length($date) &lt; 19">
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
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="monthpart">
						<xsl:value-of select="substring($date,1,2)"></xsl:value-of>
					</xsl:variable>
					<xsl:variable name="daypart">
						<xsl:value-of select="substring($date,4,2)"></xsl:value-of>
					</xsl:variable>
					<xsl:variable name="yearpart">
						<xsl:value-of select="substring($date,7,4)"></xsl:value-of>
					</xsl:variable>
					<xsl:variable name="month">
						<xsl:call-template name="GetMonthString">
							<xsl:with-param name="monthno">
								<xsl:value-of select="$monthpart"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="concat($month,concat($daypart, concat(', ',$yearpart)))"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
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
	
	
	
	<!-- BEGIN ARCHIVE NOTATION TEMPLATES -->
	<xsl:template name="news_archive_2">
		<xsl:if test="//metadata_section/wbmd_archive_bool='1'">
			<xsl:if test="//metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Drug Alerts' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Drug Approvals' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Drug Recalls' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Drugs' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - FAQ' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Product Alerts' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Product Approvals' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Product Recalls' or //metadata_section/wbmd_bus_ref/@wbmd_disp_nm='News - Vitamins'">
				<xsl:if test="normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Health News' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Health News Commentary' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Weight Loss Clinic - Medical News'">
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>archiveStamp</xsl:text></xsl:attribute>
						<xsl:element name="p">
							<xsl:text><![CDATA[This article is from the WebMD ]]></xsl:text>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:text>http://webmd.com/news-archive-popup</xsl:text></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:text>window.open(this.href, 'subWin', 'resizable=yes,scrollbars=no,width=275,height=225'); return false;</xsl:text></xsl:attribute>
								<xsl:text>News Archive</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="feature_archive_2">
		<xsl:if test="//metadata_section/wbmd_archive_bool='1'">
			<xsl:if test="//metadata_section/wbmd_bus_ref/@wbmd_disp_nm='Feature'">
				<xsl:if test="normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Feature' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Fertility Center - Feature' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD the Magazine - Feature' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Weight Loss Clinic-Exclusive Feature' or normalize-space(//wbmd_publ/wbmd_publ_display)='WebMD Weight Loss Clinic-Feature'">
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>archiveStamp</xsl:text></xsl:attribute>
						<xsl:element name="p">
							<xsl:text><![CDATA[This article is from the WebMD ]]></xsl:text>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:text>http://webmd.com/feature-archive-popup</xsl:text></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:text>window.open(this.href, 'subWin', 'resizable=yes,scrollbars=no,width=275,height=225'); return false;</xsl:text></xsl:attribute>
								<xsl:text>Feature Archive</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ArchiveNotation">
		<xsl:param name="boolInd"></xsl:param>
		<xsl:param name="storageVal"></xsl:param>
		<xsl:if test="boolInd = '1'">
			<xsl:choose>
				<xsl:when test="($storageVal = '17') or ($storageVal = '18') or ($storageVal = '19') or ($storageVal = '61') or ($storageVal = '62') or ($storageVal = '63') or ($storageVal = '20')">
					<xsl:call-template name="ArchiveNews"></xsl:call-template>
				</xsl:when>
				<xsl:when test="($storageVal = '10')">
					<xsl:call-template name="ArchiveFeature"></xsl:call-template>
				</xsl:when>
				<xsl:when test="($storageVal = '9')">
					<xsl:call-template name="ArchiveQA"></xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ArchiveNews">
		<div class="archivePopup">
			From the WebMD Archives: 
			<a href="/policies/news-archive" onClick="window.open(this.href, 'popup','width=328,height=205,scrollbars=no,resizeable=no,status=yes');return false;">Answers to Questions</a>
		</div>
	</xsl:template>
	<xsl:template name="ArchiveFeature">
		<div class="archivePopup">
			From the WebMD Archives: 
			<a href="/policies/features-archive" onClick="window.open(this.href, 'popup','width=328,height=205,scrollbars=no,resizeable=no,status=yes');return false;">Health Feature</a>
		</div>
	</xsl:template>
	<xsl:template name="ArchiveQA">
		<div class="archivePopup">
			From the WebMD Archives: 
			<a href="/policies/answers-archive" onClick="window.open(this.href, 'popup','width=328,height=205,scrollbars=no,resizeable=no,status=yes');return false;">WebMD Answers to Questions</a>
		</div>
	</xsl:template>

	<xsl:template match="citations">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<!-- END ARCHIVE NOTATION TEMPLATES -->
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- Text Templates -->
	<xsl:template name="AuthorText">
		<xsl:if test="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_first_nm">
			By 
			<xsl:variable name="furl">
				<xsl:call-template name="GetURLRef">
					<xsl:with-param name="ObjectID">
						<xsl:value-of select="ancestor::wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_bio_obj_id/@chronic_id"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$furl!=''">
					<a href="{$furl}" onclick="return sl(this,'','prog-lnk');">
						<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_first_nm, ' ')"></xsl:value-of>
						<xsl:if test="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_middle_name">
							<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_middle_name, ' ')"></xsl:value-of>
						</xsl:if>
						<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_lst_nm"></xsl:value-of>
						<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_person_suffix_group/wbmd_person_suffix">
							<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
						</xsl:for-each>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_first_nm, ' ')"></xsl:value-of>
					<xsl:if test="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_middle_name">
						<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_middle_name, ' ')"></xsl:value-of>
					</xsl:if>
					<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_lst_nm"></xsl:value-of>
					<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_authr_prim_group/wbmd_authr_prim[1]/wbmd_person_suffix_group/wbmd_person_suffix">
						<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text></xsl:text>
		</xsl:if>
	</xsl:template>
	
	
	
	<xsl:template name="ReviewerText">
		<xsl:if test="//metadata_section/wbmd_prim_med_revr/wbmd_first_nm">
			Reviewed by 
			<xsl:variable name="furl2">
				<xsl:call-template name="GetURLRef">
					<xsl:with-param name="ObjectID">
						<xsl:value-of select="ancestor::wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_bio_obj_id/@chronic_id"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$furl2!=''">
					<a onclick="return sl(this,'','prog-lnk');" href="{$furl2}">
						<xsl:value-of select="concat(//metadata_section/wbmd_prim_med_revr/wbmd_first_nm, ' ')"></xsl:value-of>
						<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name">
							<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_middle_name, ' ')"></xsl:value-of>
						</xsl:if>
						<xsl:value-of select="//metadata_section/wbmd_prim_med_revr/wbmd_lst_nm"></xsl:value-of>
						<xsl:for-each select="/webmd_rendition/content/wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_person_suffix_group/wbmd_person_suffix">
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
					<xsl:for-each select="/webmd_rendition/content/wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_person_suffix_group/wbmd_person_suffix">
						<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	
	<xsl:template name="EditorText">
		<xsl:if test="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_first_nm">
				Edited by 
			<xsl:variable name="furl2">
				<xsl:call-template name="GetURLRef">
					<xsl:with-param name="ObjectID">
						<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_c_cons_cpy_edtr/wbmd_bio_obj_id/@chronic_id"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$furl2!=''">
					<a onclick="return sl(this,'','prog-lnk');" href="{$furl2}">
						<!-- Editor Name -->
						<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_first_nm, ' ')"></xsl:value-of>
						<xsl:if test="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_middle_name">
							<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_middle_name, ' ')"></xsl:value-of>
						</xsl:if>
						<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_lst_nm"></xsl:value-of>
						<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_person_suffix_group/wbmd_person_suffix">
							<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
						</xsl:for-each>
						<!-- End Editor Name -->
					</a>
				</xsl:when>
				<xsl:otherwise>
					<!-- Editor Name -->
					<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_first_nm, ' ')"></xsl:value-of>
					<xsl:if test="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_middle_name">
						<xsl:value-of select="concat(//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_middle_name, ' ')"></xsl:value-of>
					</xsl:if>
					<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_lst_nm"></xsl:value-of>
					<xsl:for-each select="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_person_suffix_group/wbmd_person_suffix">
						<xsl:value-of select="concat(', ', @wbmd_disp_nm)"></xsl:value-of>
					</xsl:for-each>
					<!-- End Editor Name -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	
	<xsl:template name="ReviewedByOnText">
		<xsl:if test="//wbmd_asset/metadata_section/wbmd_prim_med_revr/wbmd_first_nm or (//wbmd_asset/metadata_section/wbmd_prim_revw_dt !='nulldate')">
			<div class="reviewer">
				<p>
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
				</p>
			</div>
		</xsl:if>
	</xsl:template>
	
	
	
	<xsl:template name="EditedByOnText">
		<xsl:if test="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_first_nm or (//wbmd_asset/metadata_section/wbmd_c_edtr_revr_dt !='nulldate')">
			<div class="sources">
				<div class="reviewedBy">
					<xsl:choose>
						<xsl:when test="//wbmd_asset/metadata_section/wbmd_c_cons_edtr/wbmd_first_nm">
							<xsl:call-template name="EditorText"></xsl:call-template>
							<xsl:if test="//wbmd_asset/metadata_section/wbmd_c_edtr_revr_dt!='nulldate'">
								<xsl:text> on </xsl:text>
								<xsl:call-template name="Convert_Date">
									<xsl:with-param name="date">
										<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_c_edtr_revr_dt"></xsl:value-of>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							Edited on 	
						<xsl:call-template name="Convert_Date">
								<xsl:with-param name="date">
									<xsl:value-of select="//wbmd_asset/metadata_section/wbmd_c_edtr_revr_dt"></xsl:value-of>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- End Text Templates -->
	
	
	
	
	
	
	<!-- DRUG INFO TEMPLATE-->
	<xsl:template match="block.drugs">
		<xsl:param name="display_col_1">
			<xsl:choose>
				<xsl:when test="block.drug/drug.chemical-name!=''">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:when test="block.drug/drug.generic-name!=''">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="display_col_2">
			<xsl:choose>
				<xsl:when test="block.drug/drug.brand-names/drug.brand-name!=''">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:element name="table">
			<xsl:attribute name="class"><xsl:text>drug_info</xsl:text></xsl:attribute>
			<xsl:attribute name="frame"><xsl:text>box</xsl:text></xsl:attribute>
			<xsl:attribute name="rules"><xsl:text>all</xsl:text></xsl:attribute>
			<xsl:element name="thead">
				<xsl:element name="tr">
					<xsl:if test="$display_col_1='true'">
						<xsl:element name="th">
							<xsl:text>Generic Name</xsl:text>
						</xsl:element>
					</xsl:if>
					<xsl:if test="$display_col_2='true'">
						<xsl:element name="th">
							<xsl:text>Brand Name</xsl:text>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
			<xsl:for-each select="block.drug">
				<xsl:element name="tr">
					<xsl:if test="$display_col_1='true'">
						<xsl:element name="td">
							<xsl:choose>
								<xsl:when test="drug.chemical-name">
									<xsl:apply-templates select="drug.chemical-name"></xsl:apply-templates>
								</xsl:when>
								<xsl:when test="drug.generic-name">
									<xsl:apply-templates select="drug.generic-name"></xsl:apply-templates>
								</xsl:when>
							</xsl:choose>
						</xsl:element>
					</xsl:if>
					<xsl:if test="$display_col_2='true'">
						<xsl:element name="td">
							<xsl:for-each select="drug.brand-names/drug.brand-name">
								<xsl:apply-templates></xsl:apply-templates>
								<xsl:if test="position()!=last()">
									<xsl:text><![CDATA[, ]]></xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="drug.chemical-name | drug.generic-name | drug.brand-name">
		<xsl:apply-templates></xsl:apply-templates>
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
	<xsl:template name="IsPointer">
		<xsl:param name="ObjectID"></xsl:param>
		<xsl:if test="//referenced_objects/object[@chronic_id=$ObjectID]/target/@friendlyurl">
			<xsl:choose>
				<xsl:when test="//referenced_objects/object[@chronic_id=$ObjectID][1]/@pointer = '1'">true</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetLinkType">
		<xsl:param name="Value"></xsl:param>
		<xsl:choose>
			<xsl:when test="$Value = 'Window'">nw</xsl:when>
			<xsl:when test="$Value = 'Pop Up'">sp</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EscapeApos">
		<xsl:param name="text"></xsl:param>
		<xsl:variable name="apos">&apos;</xsl:variable>
		<xsl:variable name="ntext" select="$text"></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($text,$apos)">
				<xsl:variable name="first" select="substring-before($ntext,$apos)"></xsl:variable>
				<xsl:variable name="rest-of-it" select="substring-after($ntext,$apos)"></xsl:variable>
				<xsl:value-of select="concat($first,'\',$apos)"></xsl:value-of>
				<xsl:if test="$rest-of-it">
					<xsl:call-template name="EscapeApos">
						<xsl:with-param name="text" select="$rest-of-it"></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"></xsl:value-of>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<xsl:template name="FixEscaped">
		<xsl:param name="href"></xsl:param>
		<xsl:choose>
			<!--Handle - &amp;amp;-->
			<xsl:when test="contains(string($href), '&amp;amp;')">
				<xsl:call-template name="FixEscaped">

					<xsl:with-param name="href">
						<xsl:value-of select="concat(substring-before(string($href), '&amp;amp;'), '&amp;', substring-after(string($href), '&amp;amp;'))" disable-output-escaping="no"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$href" disable-output-escaping="yes"></xsl:value-of>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--Image Template-->
	<xsl:template name="GetImg">
		<xsl:param name="src"></xsl:param>
		<xsl:param name="alt"></xsl:param>
		<img src="{$src}" alt="{$alt}"/>
	</xsl:template>
	<!--Removes Quotes and Apostrophes from the Teaser Text for the next Pages-->
	<xsl:template name="ReplaceParams">
		<xsl:param name="orig_text"></xsl:param>
		<xsl:param name="parsed_text"></xsl:param>
		<xsl:param name="param_to_replace"></xsl:param>
		<xsl:param name="param_value"></xsl:param>
		<xsl:choose>
			<xsl:when test="$orig_text != ''">
				<xsl:choose>
					<xsl:when test="contains($orig_text, $param_to_replace)">
						<xsl:call-template name="ReplaceParams">
							<xsl:with-param name="orig_text">
								<xsl:value-of select="substring-after($orig_text, $param_to_replace)" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="parsed_text">
								<xsl:value-of select="$parsed_text" disable-output-escaping="yes"></xsl:value-of>
								<xsl:value-of select="substring-before($orig_text, $param_to_replace)" disable-output-escaping="yes"></xsl:value-of>
								<xsl:value-of select="$param_value" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_to_replace">
								<xsl:value-of select="$param_to_replace"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_value">
								<xsl:value-of select="$param_value"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ReplaceParams">
							<xsl:with-param name="orig_text"></xsl:with-param>
							<xsl:with-param name="parsed_text">
								<xsl:value-of select="concat($parsed_text, $orig_text)" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_to_replace">
								<xsl:value-of select="$param_to_replace"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_value">
								<xsl:value-of select="$param_value"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$orig_text = ''">
				<xsl:value-of select="$parsed_text" disable-output-escaping="yes"></xsl:value-of>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="ReplaceRotation">
		<xsl:variable name="out1">
			<xsl:call-template name="ReplaceParams">
				<xsl:with-param name="orig_text">
					<xsl:value-of select="section_group[1]/section_header[1]"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="param_to_replace">
					<xsl:text disable-output-escaping="yes">"</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="param_value">
					<xsl:text disable-output-escaping="yes">\"</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="out2">
			<xsl:call-template name="ReplaceParams">
				<xsl:with-param name="orig_text">
					<xsl:value-of select="$out1" disable-output-escaping="yes"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="param_to_replace">
					<xsl:text disable-output-escaping="yes">'</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="param_value">
					<xsl:text disable-output-escaping="yes">\'</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$out2" disable-output-escaping="yes"></xsl:value-of>
	</xsl:template>
</xsl:stylesheet>