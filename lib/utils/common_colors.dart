import 'package:flutter/material.dart';

class CommonColors {
  static Color shimmerBaseColor = Colors.grey.withValues(alpha: .3);
  static Color shimmerHighlightColor = Colors.grey.withValues(alpha: .7);

  // Primary / brand
  static const Color primaryColor = Color(0xffC81E1E);
  static const Color primaryGradientStart = Color(0xff6B8EF8);
  static const Color primaryGradientEnd = Color(0xff4B6CF5);

  // Backgrounds
  static const Color scaffoldBgColor = Color(0xffFAFAF9);
  static const Color appBgColor = Color(0xffffffff);
  static const Color fieldBgColor = Color(0xffFFFFFF);

  // Social
  static const Color googleRed = Color(0xffEA4335);
  static const Color facebookBlue = Color(0xff1877F2);

  static const Color appColor = Color(0xff466FFF);
  static const Color blackColor = Color(0xff000000);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color orangeColor = Color(0xffEC821A);
  static const Color borderColor = Color(0xFFE8E2E1);
  static const Color hintColor = Color(0xff646368);
  static const Color greyColor = Color(0xffF0F0F0);
  static const Color dividerColor = Color(0xffECECEC);
  static const Color blueColor = Color(0xff2F80ED);
  // static const Color txtPrimary = Color(0xff111827);
  // static const Color txtSecondary = Color(0xff4B5563);
  // static const Color txtTertiary = Color(0xff6B7280);
  static const Color redB52424 = Color(0xffff0000);
  static const Color appGreenColor = Color(0xff059669);
  static const Color appRedColor = Color(0xffFA5F1C);
  static const Color greyAEAEAE = Color(0xffAEAEAE);
  static const Color grey3B4A5E = Color(0xff3B4A5E);
  static const Color greyDEE2E6 = Color(0xffDEE2E6);
  static const Color grey475569 = Color(0xff475569);
  static const Color greyF8F8F8 = Color(0xffF8F8F8);

  // ── Extra / Semantic Surfaces ──────────────────────────────────────────────
  static const Color colorTooltip = Color(0xff2E2523);
  static const Color colorOverlay = Color(0xff1A1210);
  static const Color colorInputBg = Color(0xffF4F1F0);
  static const Color colorCardBg = Color(0xffFFFFFF);
  static const Color colorCardBgHover = Color(0xffF3F4F6);
  static const Color colorAppBg = Color(0xffFAFAF9);

  // ── Primary Red (brand) ────────────────────────────────────────────────────
  static const Color primary900 = Color(0xff5C111C);
  static const Color primary800 = Color(0xff7A1322);
  static const Color primary700 = Color(0xff9A132A);
  static const Color primary600 = Color(0xffBC1A33);
  static const Color primary500 = Color(0xffC81E1E);
  static const Color primary400 = Color(0xffEB5C71);
  static const Color primary300 = Color(0xffF4929F);
  static const Color primary200 = Color(0xffFAC2CA);
  static const Color primary100 = Color(0xffFDE0E4);
  static const Color primary50 = Color(0xffFEF1F3);

  // ── Success ────────────────────────────────────────────────────────────────
  static const Color success800 = Color(0xff0A512B);
  static const Color success700 = Color(0xff0F6E3B);
  static const Color success600 = Color(0xff148A4C);
  static const Color success500 = Color(0xff1AA85D);
  static const Color success400 = Color(0xff34D399);
  static const Color success300 = Color(0xff6EE7B7);
  static const Color success200 = Color(0xff92E8B8);
  static const Color success100 = Color(0xffC6F5DA);
  static const Color success50 = Color(0xffEDFBF3);

  // ── Warning ────────────────────────────────────────────────────────────────
  static const Color warning800 = Color(0xff7C3411);
  static const Color warning700 = Color(0xffA04210);
  static const Color warning600 = Color(0xffC95817);
  static const Color warning500 = Color(0xffE76F2C);
  static const Color warning400 = Color(0xffFA823F);
  static const Color warning300 = Color(0xffFFA46E);
  static const Color warning200 = Color(0xffFFC8A4);
  static const Color warning100 = Color(0xffFFE4D0);
  static const Color warning50 = Color(0xffFFF4ED);

  // ── Error ──────────────────────────────────────────────────────────────────
  static const Color error800 = Color(0xff771717);
  static const Color error700 = Color(0xffB91C1C);
  static const Color error600 = Color(0xffDC2626);
  static const Color error500 = Color(0xffEF4444);
  static const Color error400 = Color(0xffF87171);
  static const Color error300 = Color(0xffFCA5A5);
  static const Color error200 = Color(0xffFECACA);
  static const Color error100 = Color(0xffFEE2E2);
  static const Color error50 = Color(0xffFEF2F2);

  // ── Info Blue ──────────────────────────────────────────────────────────────
  static const Color info800 = Color(0xff1B367F);
  static const Color info700 = Color(0xff1A3FA1);
  static const Color info600 = Color(0xff1D4FCB);
  static const Color info500 = Color(0xff2563EB);
  static const Color info400 = Color(0xff6088F7);
  static const Color info300 = Color(0xff93B0FB);
  static const Color info200 = Color(0xffBFD0FD);
  static const Color info100 = Color(0xffDBE5FE);
  static const Color info50 = Color(0xffEFF4FF);

  // ── Border ─────────────────────────────────────────────────────────────────
  static const Color borderDefault = Color(0xffD6D3D1);
  static const Color borderStrong = Color(0xffA8A29E);
  static const Color borderSubtle = Color(0xFFE7E5E4);
  static const Color borderFocus = Color(0xffD8253E);
  static const Color borderError = Color(0xffEF4444);
  static const Color borderSuccess = Color(0xff1AA85D);


  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xff0C0A09);
  static const Color textSecondary = Color(0xff57534E);
  static const Color textTertiary = Color(0xff78716C);
  static const Color textPlaceholder = Color(0xffA8A29E);
  static const Color textDisabled = Color(0xffA8A29E);
  static const Color textBrand = Color(0xffE41F07);
  static const Color textError = Color(0xffDC2626);
  static const Color textSuccess = Color(0xff059669);
  static const Color textWarning = Color(0xffB45309);
  static const Color textInfo = Color(0xff2563EB);

  // ── Grey Scale ─────────────────────────────────────────────────────────────
  static const Color grey950 = Color(0xff0C0A09);
  static const Color grey900 = Color(0xff1C1917);
  static const Color grey850 = Color(0xff221F1D);
  static const Color grey800 = Color(0xff292524);
  static const Color grey750 = Color(0xff363230);
  static const Color grey700 = Color(0xff44403C);
  static const Color grey650 = Color(0xff4D4945);
  static const Color grey600 = Color(0xff57534E);
  static const Color grey550 = Color(0xff67625D);
  static const Color grey500 = Color(0xff78716C);
  static const Color grey450 = Color(0xff908A85);
  static const Color grey400 = Color(0xffA8A29E);
  static const Color grey350 = Color(0xffBFBBB7);
  static const Color grey300 = Color(0xffD6D3D1);
  static const Color grey250 = Color(0xffDDDAD7);
  static const Color grey200 = Color(0xffE7E5E4);
  static const Color grey150 = Color(0xffEEEDEB);
  static const Color grey100 = Color(
    0xffF5F5F4,
  ); // source doc spells this "Gray 100" (typo — should be "Grey")
  static const Color grey75 = Color(0xffF7F6F5);
  static const Color grey50 = Color(0xffFAFAF9);
  static const Color grey25 = Color(0xffFCFCFB);

  // ── Red Scale ──────────────────────────────────────────────────────────────
  static const Color red900 = Color(0xff7F1D1D);
  static const Color red800 = Color(0xff991B1B);
  static const Color red700 = Color(0xffB91C1C);
  static const Color red600 = Color(0xffDC2626);
  static const Color red500 = Color(0xffEF4444);
  static const Color red400 = Color(0xffF87171);
  static const Color red300 = Color(0xffFCA5A5);
  static const Color red200 = Color(0xffFECACA);
  static const Color red100 = Color(0xffFEE2E2);
  static const Color red50 = Color(0xffFEF1F3);

  // ── Green Scale ────────────────────────────────────────────────────────────
  // green900: source file has #FFFFFF (white) which is wrong — using #064E3B
  // pending design confirmation before shipping.
  static const Color green800 = Color(0xff0A573A);
  static const Color green700 = Color(0xff0B6E48);
  static const Color green600 = Color(0xff0E8A57);
  static const Color green500 = Color(0xff15A36A);
  static const Color green400 = Color(0xff34D399);
  static const Color green300 = Color(0xff6EE7B7);
  static const Color green200 = Color(0xffA7F3D0);
  static const Color green100 = Color(0xffD1FAE5);
  static const Color green50 = Color(0xffECFDF5);

  // ── Percentage Indicator ───────────────────────────────────────────────────
  static const Color percent1to20 = Color(0xff991B1B);
  static const Color percent21to40 = Color(0xffEA580C);
  static const Color percent41to60 = Color(0xffD97706);
  static const Color percent61to80 = Color(0xff65A30D);
  static const Color percent81to100 = Color(0xff16A34A);
}
