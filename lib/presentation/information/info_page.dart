import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/styles_manager.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  InfoPage({Key? key}) : super(key: key);
  final url = Uri.parse('www.FightONMentality.com');
  _launchUrl() async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// Future<void> _launchUrl() async {
//   if (!await launchUrl(url)) {
//     throw 'Could not launch $url';
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Fight ON! Mentality",
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: AppSize.s28),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                  text: "At ",
                  style: getLightStyle(
                      color: ColorManager.primary, fontSize: AppSize.s14),
                  children: [
                    TextSpan(
                      text: "www.FightONMentality.com",
                      style: getSemiBoldStyle(
                          color: ColorManager.buttonColor,
                          fontSize: AppSize.s18),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchUrl(),
                    ),
                    const TextSpan(
                        text:
                            ", we've created an Artificial Intelligence (AI) and Machine Learning (ML) based, online learning platform, while using Virtual Reality (VR) to achieve new levels of human performance with cognitive training to train the mind all in the METAVERSE."),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "The 7-key principles of the Fight ON! Mentality include:",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "1. Be Fearless \n2. I Am Possible\n3. Growth Mindset\n4. Habits of Success\n5. Mental Toughness\n6. Be Obsessive\n7. Focus on the Now",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "We combine key principles of education, psychology, meditation, neuroscience, sports science, and immersive media to build mental mindset training, interactive content, and neuro-analytics to help people improve focus, decision making, and situational awareness that translates to improving overall performance. We’ve developed a unique and proven approach in transforming individuals and organizations by developing an unbreakable mental mindset.   We build a Fight On! Mentality by providing the online training and tools using immersive, engaging, and interactive content to inspire individuals to allow themselves to be their very best every day - in sports with teammates, at work with colleagues, or at home with family and friends.  “Fight On!” in its simplest term means to keep pushing forward even in the face of adversity."
              "​Whether you are in a sporting competition, a business environment, a personal dilemma, or wherever else you may find adversity, it is important to remember to keep going and Fight ON!",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "With the Fight ON! Mentality, people across all walks of life from professional sports athletes, business people, entrepreneurs, students, children, teenagers, and parents can achieve peak performance in their lives. ",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "How To Use This Journal",
              style: getSemiBoldStyle(
                  color: ColorManager.primary, fontSize: AppSize.s18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "We believe that mental mindset training develops mental toughness to allow individuals to achieve peak mental performance. We've worked closely with several mental psychologists, business leaders, successful coaches, and educational experts to create our online learning platform that is not only engaging, interactive, inspirational, and motivational but also easy to use on a daily basis.\n"
              "\n"
              "As part of your mental mindset training, we’ve developed this journal to help you identify, track, and measure your goals and strengthen your mindset using visualization, self-talk, and focus. Setting goals helps trigger new behaviors, helps guides your focus and helps you sustain that momentum in life. Goals also help align your focus and promote a sense of self-mastery."
              "\n"
              "Each day, simply follow these steps and enter your corresponding responses:",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "1. Be laser focused and enter today’s #1 GOAL \n2. Enter your long term S.M.A.R.T. GOALS. The goals must be Specific, Measureable, Achievable, Relevant, and Time-bound\n3. In order to reach your goals, identify things that you need to 1) CONTINUE doing, 2) START doing, and 3) STOP doing.\n4. Enter a few things that you have LEARNED and ACCOMPLISHED during the day.\n5. Finally, enter at least 1 exercise that you will be doing for VISUALIZATION (creating visual images in your mind), SELF-TALK (positive things you say to yourself), and FOCUS (how you maintain your concentration).",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "This journal is important because you can't manage what you don't measure and you can't improve upon something that you don't properly manage.",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "In order for this journal to be effective and beneficial, you have to be motivated, committed, and disciplined to make a journal entry EVERY DAY! As you build your daily entries, refer back to the accomplishments you have achieved. Take this journal everywhere you go. When you need a boost of confidence, review some of your past entries. Refer to the journal when you are down. Refer to the journal when you are proud. Use the journal to reflect on how far you have come in developing your unbreakable mental mindset. Continue to build your mental mindset and Fight ON!",
              style: getLightStyle(
                  color: ColorManager.primary, fontSize: AppSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}
