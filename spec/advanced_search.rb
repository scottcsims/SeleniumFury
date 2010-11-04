class AdvancedSearch
	def initialize *browser
		@browser = *browser
		@_ex_kw = "_ex_kw"
		@_fss = "_fss"
		@_in_kw = "_in_kw"
		@_lh_avail_to_radio = "LH_AvailToRadio"
		@_lh_fav_sellers_id = "LH_FavSellers_id"
		@_lh_located_in_radio = "LH_LocatedInRadio"
		@_lh_pref_loc_radio = "LH_PrefLocRadio"
		@_lh_sale_currencydrop_down = "LH_SALE_CURRENCYDropDown"
		@_lh_seller_with_store_id = "LH_SellerWithStore_id"
		@_lh_specific_seller_id = "LH_SpecificSeller_id"
		@_lh_sub_location = "LH_SubLocation"
		@_lh_top_rated_sellers_id = "LH_TopRatedSellers_id"
		@_m_pr_rng_cbx = "_mPrRngCbx"
		@_nkw = "_nkw"
		@_saact_select = "_saactSelect"
		@_sacat = "_sacat"
		@_salic_select = "_salicSelect"
		@_sargn_select = "_sargnSelect"
		@_sasl = "_sasl"
		@_saslop = "_saslop"
		@_udhi = "_udhi"
		@_udlo = "_udlo"
		@adv_search_from = "adv_search_from"
		@header_search = "headerSearch"
		@html_idfor_checboxv4_17 = "htmlIDforChecboxv4-17"
		@html_idfor_cityv4_21 = "htmlIDforCityv4-21"
		@html_idfor_radiusv4_19 = "htmlIDforRadiusv4-19"
		@html_idfor_zip_codev4_20 = "htmlIDforZipCodev4-20"
		@sr_con_nkw = "sr_con__nkw"
		@v4_1 = "v4-1"
		@v4_2 = "v4-2"
		@v4_advsearch0_lh_auction = "v4-advsearch0_LH_Auction"
		@v4_advsearch0_lh_gifast = "v4-advsearch0_LH_GIFAST"
		@v4_advsearch0_lh_pay_pal = "v4-advsearch0_LH_PayPal"
		@v4_advsearch0_lh_title_desc = "v4-advsearch0_LH_TitleDesc"
		@v4_advsearch1__lh_time = "v4-advsearch1__LH_Time"
		@v4_advsearch1_ftrt = "v4-advsearch1__ftrt"
		@v4_advsearch1_ftrv = "v4-advsearch1__ftrv"
		@v4_advsearch1_lh_bin = "v4-advsearch1_LH_BIN"
		@v4_advsearch1_lh_complete = "v4-advsearch1_LH_Complete"
		@v4_advsearch1_lh_fs = "v4-advsearch1_LH_FS"
		@v4_advsearch2__lh_nob = "v4-advsearch2__LH_NOB"
		@v4_advsearch2_lh_cads = "v4-advsearch2_LH_CAds"
		@v4_advsearch2_lh_lpickup = "v4-advsearch2_LH_LPickup"
		@v4_advsearch2_sabdhi = "v4-advsearch2__sabdhi"
		@v4_advsearch2_sabdlo = "v4-advsearch2__sabdlo"
		@v4_advsearch3__lh_mil = "v4-advsearch3__LH_MIL"
		@v4_advsearch3_samihi = "v4-advsearch3__samihi"
		@v4_advsearch3_samilow = "v4-advsearch3__samilow"
		@v4_advsearch4_lh_lots = "v4-advsearch4_LH_Lots"
		@v4_advsearch5_lh_sale_items = "v4-advsearch5_LH_SaleItems"
		@v4_advsearch6_lh_bo = "v4-advsearch6_LH_BO"
		@v4_advsearch7_lh_charity = "v4-advsearch7_LH_Charity"
		@v4_advsearch8_lh_rebate_eligible = "v4-advsearch8_LH_RebateEligible"
	end
	attr_accessor :browser, :_ex_kw, :_fss, :_in_kw, :_lh_avail_to_radio,
	:_lh_fav_sellers_id, :_lh_located_in_radio, :_lh_pref_loc_radio, :_lh_sale_currencydrop_down, :_lh_seller_with_store_id,
	:_lh_specific_seller_id, :_lh_sub_location, :_lh_top_rated_sellers_id, :_m_pr_rng_cbx, :_nkw,
	:_saact_select, :_sacat, :_salic_select, :_sargn_select, :_sasl,
	:_saslop, :_udhi, :_udlo, :adv_search_from, :header_search,
	:html_idfor_checboxv4_17, :html_idfor_cityv4_21, :html_idfor_radiusv4_19, :html_idfor_zip_codev4_20, :sr_con_nkw,
	:v4_1, :v4_2, :v4_advsearch0_lh_auction, :v4_advsearch0_lh_gifast, :v4_advsearch0_lh_pay_pal,
	:v4_advsearch0_lh_title_desc, :v4_advsearch1__lh_time, :v4_advsearch1_ftrt, :v4_advsearch1_ftrv, :v4_advsearch1_lh_bin,
	:v4_advsearch1_lh_complete, :v4_advsearch1_lh_fs, :v4_advsearch2__lh_nob, :v4_advsearch2_lh_cads, :v4_advsearch2_lh_lpickup,
	:v4_advsearch2_sabdhi, :v4_advsearch2_sabdlo, :v4_advsearch3__lh_mil, :v4_advsearch3_samihi, :v4_advsearch3_samilow,
	:v4_advsearch4_lh_lots, :v4_advsearch5_lh_sale_items, :v4_advsearch6_lh_bo, :v4_advsearch7_lh_charity, :v4_advsearch8_lh_rebate_eligible

end