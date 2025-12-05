import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_feed/data/repository/network_api/job_feed_network_api_repository.dart';
import 'package:job_feed/presentation/provider/job_post_provider.dart';
import 'package:job_feed/presentation/screen/job_feed_screen.dart';
import 'package:provider/provider.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              JobPostProvider(repository: JobFeedNetworkApiRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // Use Noto Sans Khmer for proper Khmer character display
          textTheme: GoogleFonts.notoSansKhmerTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const JobFeedScreen(),
      ),
    );
  }
}
