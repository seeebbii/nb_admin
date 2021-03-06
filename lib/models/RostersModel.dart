import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RostersModel extends StatefulWidget {
  String id;
  String name;
  String role;
  String facebookLink;
  String youtubeLink;
  String twitterLink;
  String instaLink;
  String discordLink;

  RostersModel(this.id, this.name, this.role, this.facebookLink,
      this.youtubeLink, this.twitterLink, this.discordLink, this.instaLink);

  @override
  _RostersModelState createState() => _RostersModelState();
}

class _RostersModelState extends State<RostersModel> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Image.asset('assets/logo/lion.png', height: 50,),
      title: ListTile(
        title: Text(widget.name, style: TextStyle(
            color: isExpanded ? Colors.purpleAccent.shade100 : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          letterSpacing: 1.5
        ),),
        subtitle: Text(widget.role,
        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 15
        ),),
      ),
      childrenPadding: const EdgeInsets.only(bottom: 18, top: 18),
      onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: (){
                  // _launchURL(widget.facebookLink);
                  copyToClipbord(widget.facebookLink);
                },
                child: Image.asset(
                  'assets/logo/fb.png',
                  height: 60,
                  width: 50,
                )),
            GestureDetector(
              onTap: () {
                // _launchURL(widget.discordLink);
                copyToClipbord(widget.discordLink);
              },
              child: Image.asset(
                'assets/logo/discord.png',
                height: 60,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                // _launchURL(widget.instaLink);
                copyToClipbord(widget.instaLink);
              },
              child: Image.asset(
                'assets/logo/insta.png',
                height: 60,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                // _launchURL(widget.twitterLink);
                copyToClipbord(widget.twitterLink);
              },
              child: Image.asset(
                'assets/logo/twitter.png',
                height: 60,
                width: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                // _launchURL(widget.youtubeLink);
                copyToClipbord(widget.youtubeLink);
              },
              child: Image.asset(
                'assets/logo/youtube.png',
                height: 60,
                width: 50,
              ),
            ),
          ],
        )
      ],
    );
  }

  copyToClipbord(String url){
    ClipboardManager.copyToClipBoard(url).then((result) {
      final snackBar = SnackBar(
        content: Text('Copied to Clipboard'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
