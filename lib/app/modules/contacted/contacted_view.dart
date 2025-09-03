import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart'; // Indi bu gerek däl
import 'package:get/get.dart';
import 'package:haly/app/modules/contacted/contacted_controller.dart';
import 'package:haly/app/modules/contacted/widgets/contact_card.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';
import 'package:haly/app/widgets/custom_app_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends GetView<ContactedController> {
  ContactScreen({super.key});
  @override
  final ContactedController controller = Get.put(ContactedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child:
                        Lottie.asset('assets/images/processing-circle.json')));
          } else if (controller.hasError.value) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 52.0 : 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                    SizedBox(height: isTablet ? 24 : 16),
                    Center(
                      child: Image.asset(
                        Assets.logo,
                        height: isTablet ? 102 : 60,
                        width: 166,
                      ),
                    ),
                    SizedBox(height: isTablet ? 30 : 20),
                    Text("Habarlaşmak üçin",
                        style: TextStyle(
                            fontSize: isTablet ? 24 : 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold,
                            color: AppColors.green)),
                    const SizedBox(height: 18),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl(
                          'https://www.google.com/maps?q=Aşgabat,10+ýyl+Abadançylyk+25'),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedLocation01,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Bizin salgymyz",
                        subtitle:
                            "Türkmenistan, Aşgabat şäheri, Abadan Etrap, Altyn Asyr köçesi, jaý 27",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl("mailto:info@biznes.tm"),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedMail01,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Email",
                        subtitle: "info@naduaashgabat.com.tm",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl('tel:+99312399006'),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedTelephone,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Telefon belgimiz",
                        subtitle: "+993-12-39-90-06",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedPrinter,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "FAX",
                        subtitle: "39-90-05",
                        isTablet: isTablet,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (controller.contacts.isEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 52.0 : 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                    SizedBox(height: isTablet ? 24 : 16),
                    Center(
                      child: Image.asset(
                        Assets.logo,
                        height: isTablet ? 102 : 60,
                        width: 166,
                      ),
                    ),
                    SizedBox(height: isTablet ? 30 : 20),
                    Text("Habarlaşmak üçin",
                        style: TextStyle(
                            fontSize: isTablet ? 24 : 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold,
                            color: AppColors.green)),
                    const SizedBox(height: 18),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl(
                          'https://www.google.com/maps?q=Aşgabat,10+ýyl+Abadançylyk+25'),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedLocation01,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Bizin salgymyz",
                        subtitle:
                            "Türkmenistan, Aşgabat şäheri, Abadan Etrap, Altyn Asyr köçesi, jaý 27",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl("mailto:info@biznes.tm"),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedMail01,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Email",
                        subtitle: "info@naduaashgabat.com.tm",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () => _launchUrl('tel:+99312399006'),
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedTelephone,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "Telefon belgimiz",
                        subtitle: "+993-12-39-90-06",
                        isTablet: isTablet,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      child: ContactCard(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedPrinter,
                          size: 32,
                          color: Colors.green,
                        ),
                        title: "FAX",
                        subtitle: "39-90-05",
                        isTablet: isTablet,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 52.0 : 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                    SizedBox(height: isTablet ? 24 : 16),
                    Center(
                      child: Image.asset(
                        Assets.logo,
                        height: isTablet ? 102 : 60,
                        width: 166,
                      ),
                    ),
                    SizedBox(height: isTablet ? 30 : 20),
                    Text(
                      "Habarlaşmak üçin",
                      style: TextStyle(
                          fontSize: isTablet ? 24 : 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: Fonts.gilroySemiBold,
                          color: AppColors.green),
                    ),
                    const SizedBox(height: 18),
                    ...controller.contacts.map((contact) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () => contact.link != null
                            ? _launchUrl(contact.link!)
                            : null,
                        child: ContactCard(
                          icon: _getIconForContact(contact.icon),
                          title: contact.title,
                          subtitle: contact.description,
                          isTablet: isTablet,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }
        });
      }),
    );
  }

  Widget _getIconForContact(String iconUrl) {
    IconData iconData;
    if (iconUrl.contains('email')) {
      iconData = HugeIcons.strokeRoundedMail01;
    } else if (iconUrl.contains('address')) {
      iconData = HugeIcons.strokeRoundedLocation08;
    } else if (iconUrl.contains('phone')) {
      iconData = HugeIcons.strokeRoundedTelephone;
    } else if (iconUrl.contains('instagram')) {
      iconData = HugeIcons.strokeRoundedInstagram;
    } else if (iconUrl.contains('tiktok')) {
      iconData = HugeIcons.strokeRoundedTiktok;
    } else if (iconUrl.contains('fax')) {
      iconData = HugeIcons.strokeRoundedPrinter;
    } else {
      iconData = HugeIcons.strokeRoundedLink01;
    }

    return HugeIcon(
      icon: iconData,
      size: 32,
      color: AppColors.green,
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }
}
