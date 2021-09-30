// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TC extends StatefulWidget {
  TC({Key? key}) : super(key: key);

  @override
  _TCState createState() => _TCState();
}

class _TCState extends State<TC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF02B3E8),
                  Color(0xFF1A55B3),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            )),
            title: Text("T&C"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "images/back.png",
                ),
              ),
            )),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
              // ignore: prefer_const_constructors
              Terms(
                  title: "Modification of Terms & Conditions of Service",
                  subtitle:
                      "Jan Shakti Dudh Depo may at any time modify the Terms & Conditions of Use of the application without any prior notification to you. You can access the latest version of these Terms & Conditions at any given time on the App. You should regularly review the Terms & Conditions on the App. In the event the modified Terms & Conditions is not acceptable to you, you should discontinue using the Service. However, if you continue to use the Service you shall be deemed to have agreed to accept and abide by the modified Terms & Conditions of Use for our Application"),
              const Terms(
                  title: "Objectionable Material",
                  subtitle:
                      "You understand that by using this Application or any Services provided on the App, you may encounter Content that may be deemed by some to be offensive, indecent, or objectionable, which Content may or may not be identified as such. You agree to use the App and any service at your sole risk and that to the fullest extent permitted under applicable law, Jan Shakti Dudh Depo and its affiliates shall have no liability to you for Content that may be deemed offensive, indecent, or objectionable to you"),
              const Terms(
                  title: "Colors",
                  subtitle:
                      "We have made every effort to display the colors of our products that appear on the application as accurately as possible. However, as the actual colors you see will depend on your monitor, we cannot guarantee that your monitor display of any color will be accurate."),
              const Terms(
                  title: "Services overview",
                  subtitle:
                      "As part of the registration process on the App, JSDD may collect the following personally identifiable information about you: Name including first and last name, alternate email address, mobile phone number and contact details, Postal code, Demographic profile (like your age, gender, address, etc."),
              const Terms(
                  title: "Eligibility",
                  subtitle:
                      'Services of the App would be available to only select geographies in India. Persons who are "incompetent to contract" within the meaning of the Indian Contract Act, 1872 including un-discharged insolvents, etc. are not eligible to use the App. If you are a minor i.e. under the age of 18 years you are barred from using the services provided by JSDD'),
              const Terms(
                  title: "Personal Identifiable Information",
                  subtitle:
                      "Jan Shakti Dudh Depo is the licensed owner of the brand Jan Shakti Dudh Depo. We respect your privacy. Privacy Policy provides succinctly the manner your data is collected and used by Jan Shakti Dudh Depo on the App. As a visitor to the App/Customer, you are advised to please read the Privacy Policy carefully. By accessing the services provided by the Application you agree to the collection and use of your data by Jan Shakti Dudh Depo in the manner provided in this Privacy Policy"),
              const Terms(
                  title: "Privacy Policy",
                  subtitle:
                      'JSDD the "Jan Shakti Dudh Depo" is committed to maintaining robust privacy protections for its users. Our Privacy Policy "Privacy Policy" is designed to help you understand how we collect, use and safeguard the information you provide to us and to assist you in making informed decisions when using our Service For purposes of this Agreement, "App" refers to the Company, which can be accessed through our mobile application."Service" refers to the Companys services accessed via the application, in which users can buy organic cow milk, buffalo milk, and other dairy products. The terms "we”, "us," and "our" refer to the Company. "You" refers to you, as a user/Admin of our application or our Service By accessing our App or our Service, you accept our Privacy Policy and Terms of Use and you consent to our collection, storage, use, and disclosure of your Personal Information as described in this Privacy Policy'),
// Information we collect......
              ExpansionTile(
                title: Text(
                  ' INFORMATION WE COLLECT',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(
                      fontSize: 17.0, fontWeight: FontWeight.w600),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    child: Text(
                      'We collect "Non-Personal Information" and "Personal Information." Non-Personal Information includes information that cannot be used to personally identify you, such as anonymous usage data, general demographic information we may collect platform types, preferences you submit, and preferences that are generated based on the data you submit. Personal Information includes your name, phone number email address, full residential address along with city pin-code, which you submit to us through the registration process in the application',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                          fontSize: 17.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Terms(
                      title: "Information collected via Technology",
                      subtitle:
                          "To activate the Service you do not need to submit any Personal Information other than your name, phone number, email address, full residential address along with your city pin-code. To use the Service thereafter, you do not need to submit further Personal Information. However, to improve the quality of the Service, we track information provided to us by our application when you view or use the Service the device from which you connected to the Service, the time and date of access, and other information that does not personally identify you"),
                  Terms(
                      title:
                          " Information you provide us by registering for an account",
                      subtitle:
                          'In addition to the information provided automatically by your application when you visit the JSDD app, to become a subscriber to the Service you will need to create a personal profile. You can create a profile by registering with the Service and entering your contact info and creating a user name and a password. By registering, you are authorizing us to collect, store and use your contact info in accordance with this Privacy Policy'),
                  Terms(
                      title: "Children's Privacy",
                      subtitle:
                          'The Application and the Service are not directed to anyone below the age of 18. The App does not knowingly collect or solicit information from anyone below the age of 18, or allow anyone below the age of 18 to sign up for the Service. In the event that we learn that we have gathered personal information from anyone below the age of 18 without the consent of a parent or guardian, we will delete that information as soon as possible. If you believe we have collected such information, please contact us at Jsdd@gmail.com'),
                ],
              ),
              // How we use share Information.....
              ExpansionTile(
                title: Text(
                  " HOW  WE  USE  AND  SHARE  INFORMATION",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontSize: 17.0, fontWeight: FontWeight.w600),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Terms(
                      title: 'Personal Information',
                      subtitle: 'Except as otherwise stated in this Privacy Policy, we do not sell, trade, rent or share for marketing purposes your Personal Information with third parties without your consent. We do share Personal Information with vendors who are performing services for the Company, such as the servers for our email communications, databases who are provided access to the users email address for purposes of sending emails from us. Those vendors use your Personal Information only at our direction and in accordance with our Privacy Policy.+'
                              'In general, the Personal Information you provide to us is used to help us communicate with you. For example, we use Personal Information to contact users in response to questions, solicit feedback from users, provide technical support, and inform users about promotional offers.' +
                          'We may share Personal Information with outside parties if we have a good-faith belief that access, use, preservation, or disclosure of the information is reasonably necessary to meet any applicable legal process or enforceable governmental request; to enforce applicable Terms of Service, including investigation of potential violations: address fraud, security or technical concerns; or to protect against harm to the rights, property, or safety of our users or the public as required or permitted by law'),
                  Terms(
                      title: 'Non-Personal Information',
                      subtitle:
                          'In general, we use Non-Personal Information to help us improve the Service and customize the user experience. We also aggregate Non-Personal Information in order to track trends and analyze use patterns on the App. This Privacy Policy does not limit in any way our use or disclosure of Non-Personal Information and we reserve the right to use and disclose such Non-Personal Information to our partners, advertisers, and other third parties at our discretion.' +
                              'In the event we undergo a business transaction such as a merger, acquisition by another company, or sale of all or a portion of our assets, your Personal Information may be among the assets transferred. You acknowledge and consent that such transfers may occur and are permitted by this Privacy Policy and that any acquirer of our assets may continue to process your Personal Information as set forth in this Privacy Policy. If our information practices change at any time in the future, we will post the policy changes on the application so that you may opt-out of the new information practices. We suggest that you check the application periodically if you are concerned about how your information is used.'),
                ],
              ),
              const Terms(
                  title: 'HOW WE PROTECT INFORMATION',
                  subtitle:
                      'We implement security measures designed to protect your information from unauthorized access. Your account is protected by your account password and we urge you to take steps to keep your personal information safe by not disclosing your password and by logging out of your account after each use. We further protect your information from potential security breaches by implementing certain technological security measures including encryption, firewalls, and secure socket layer technology. However, these measures do not guarantee that your information will not be accessed, disclosed, altered, or destroyed by breach of such firewalls and secure server software. By using our Service, you acknowledge that you understand and agree to assume these risks.'),
              const Terms(
                  title: 'CHANGES TO OUR PRIVACY POLICY',
                  subtitle:
                      'The Company reserves the right to change this policy and our Terms of Service at any time. We will notify you of significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a prominent notice on our application. Significant changes will go into effect 30 days following such notification. Non-material changes or clarifications will take effect immediately.' +
                          'You should periodically check the application and this privacy page for updates'),
              const Terms(
                  title: 'CONTACT US',
                  subtitle:
                      'If you have any questions regarding this Privacy Policy or the practices of this app, please contact us by sending an email to info@grapestudioenterprise.in' +
                          ' Last Updated: This Privacy Policy was last updated on 04/09/2021')
            ]))));
  }
}

class Terms extends StatefulWidget {
  final String title;
  final String subtitle;

  const Terms({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(fontSize: 17.0, fontWeight: FontWeight.w600),
      ),
      onExpansionChanged: (value) {
        setState(() {
          value = true;
        });
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Text(
            widget.subtitle,
            textAlign: TextAlign.justify,
            style: GoogleFonts.roboto(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
