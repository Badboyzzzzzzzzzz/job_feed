// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_feed/model/jp_experience_level.dart';
import 'package:job_feed/model/jp_province.dart';
import 'package:job_feed/model/jp_type.dart';
import 'package:job_feed/presentation/provider/job_post_provider.dart';
import 'package:job_feed/presentation/screen/theme/job_post_app_theme.dart';
import 'package:job_feed/presentation/screen/widget/job_feed_card_widget.dart';
import 'package:job_feed/presentation/screen/widget/job_feed_filter_chip_widget.dart';
import 'package:job_feed/presentation/screen/widget/job_feed_filter_screen_widget.dart';
import 'package:provider/provider.dart';

class JobFeedScreen extends StatefulWidget {
  const JobFeedScreen({super.key});

  @override
  State<JobFeedScreen> createState() => _JobFeedScreenState();
}

class _JobFeedScreenState extends State<JobFeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  Set<int> bookmarkedJobs = {};
  String _selectedLanguage = 'KH';

  // Filter selections
  Province? _selectedProvince;
  JbTypeWork? _selectedWorkType;
  JbExperienceLevel? _selectedExperienceLevel;

  List<Province> _allProvinces = [];
  List<JbTypeWork> _allWorkTypes = [];
  List<JbExperienceLevel> _allExperienceLevels = [];
  bool _filterOptionsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Fetch job posts when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialJobPosts();
    });
  }

  /// Fetch initial job posts and store all filter options
  Future<void> _fetchInitialJobPosts() async {
    final provider = context.read<JobPostProvider>();
    await provider.fetchJobPosts(languageCode: _selectedLanguage);

    /// Store all filter options from the initial unfiltered response
    provider.jobPostListResponse.when(
      empty: () {},
      loading: () {},
      error: (_) {},
      success: (data) {
        if (!_filterOptionsLoaded) {
          setState(() {
            _allProvinces = _getUniqueProvinces(data.results);
            _allWorkTypes = _getUniqueWorkTypes(data.results);
            _allExperienceLevels = _getUniqueExperienceLevels(data.results);
            _filterOptionsLoaded = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchJobPosts({String? search}) {
    context.read<JobPostProvider>().fetchJobPosts(
      languageCode: _selectedLanguage,
      search: search,
      provinceRefId: _selectedProvince?.refId,
      jbTypeWorkRefId: _selectedWorkType?.refId,
      jbExperienceLevelRefId: _selectedExperienceLevel?.refId,
    );
  }

  /// Get unique provinces from job posts
  List<Province> _getUniqueProvinces(List<dynamic> jobs) {
    final Map<int, Province> uniqueProvinces = {};
    for (final job in jobs) {
      final province = job.address?.province;
      if (province != null && !uniqueProvinces.containsKey(province.id)) {
        uniqueProvinces[province.id] = province;
      }
    }
    return uniqueProvinces.values.toList();
  }

  /// Get unique work types from job posts
  List<JbTypeWork> _getUniqueWorkTypes(List<dynamic> jobs) {
    final Map<int, JbTypeWork> uniqueWorkTypes = {};
    for (final job in jobs) {
      final workType = job.jbTypeWork;
      if (workType != null && !uniqueWorkTypes.containsKey(workType.id)) {
        uniqueWorkTypes[workType.id] = workType;
      }
    }
    return uniqueWorkTypes.values.toList();
  }

  /// Get unique experience levels from job posts
  List<JbExperienceLevel> _getUniqueExperienceLevels(List<dynamic> jobs) {
    final Map<int, JbExperienceLevel> uniqueLevels = {};
    for (final job in jobs) {
      final level = job.jbExperienceLevel;
      if (level != null && !uniqueLevels.containsKey(level.id)) {
        uniqueLevels[level.id] = level;
      }
    }
    return uniqueLevels.values.toList();
  }

  /// Show location filter dialog
  Future<void> _showLocationFilter(List<Province> provinces) async {
    final result = await JobFeedFilterDialog.show<Province>(
      context,
      items: provinces,
      initialSelection: _selectedProvince,
      title: 'ជ្រើសរើសទីតាំង',
      titleIcon: Icons.location_on_outlined,
      getItemName: (province) => province.name,
    );

    if (result != _selectedProvince) {
      setState(() {
        _selectedProvince = result;
      });
      _fetchJobPosts(search: _searchController.text);
    }
  }

  /// Show work type filter dialog
  Future<void> _showWorkTypeFilter(List<JbTypeWork> workTypes) async {
    final result = await JobFeedFilterDialog.show<JbTypeWork>(
      context,
      items: workTypes,
      initialSelection: _selectedWorkType,
      title: 'ជ្រើសរើសប្រភេទការងារ',
      titleIcon: Icons.work_outline,
      getItemName: (workType) => workType.name,
    );

    if (result != _selectedWorkType) {
      setState(() {
        _selectedWorkType = result;
      });
      _fetchJobPosts(search: _searchController.text);
    }
  }

  /// Show experience level filter dialog
  Future<void> _showExperienceLevelFilter(
    List<JbExperienceLevel> levels,
  ) async {
    final result = await JobFeedFilterDialog.show<JbExperienceLevel>(
      context,
      items: levels,
      initialSelection: _selectedExperienceLevel,
      title: 'ជ្រើសរើសបទពិសោធន៍',
      titleIcon: Icons.trending_up,
      getItemName: (level) => level.name,
    );

    if (result != _selectedExperienceLevel) {
      setState(() {
        _selectedExperienceLevel = result;
      });
      _fetchJobPosts(search: _searchController.text);
    }
  }

  void _toggleBookmark(int index) {
    setState(() {
      if (bookmarkedJobs.contains(index)) {
        bookmarkedJobs.remove(index);
      } else {
        bookmarkedJobs.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JobPostAppTheme.backgroundColor,
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: JobPostAppTheme.appHeaderGradient.colors,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Top Bar with back button, title, and menu
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'ការងារ',
                              style: GoogleFonts.notoSansKhmer(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          offset: const Offset(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white,
                          onSelected: (String value) {
                            setState(() {
                              _selectedLanguage = value;
                              /// Reset filter options when language changes
                              _filterOptionsLoaded = false;
                              _selectedProvince = null;
                              _selectedWorkType = null;
                              _selectedExperienceLevel = null;
                            });
                            _fetchInitialJobPosts();
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<String>(
                              value: 'EN',
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedLanguage == 'EN'
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: _selectedLanguage == 'EN'
                                        ? const Color(0xFFE65100)
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text('English'),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'KH',
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedLanguage == 'KH'
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: _selectedLanguage == 'KH'
                                        ? const Color(0xFFE65100)
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text('ខ្មែរ'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 32,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.notoSansKhmer(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'ស្វែងរកការងារ និងក្រុមហ៊ុន',
                                hintStyle: GoogleFonts.notoSansKhmer(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 2),
                            child: ElevatedButton(
                              onPressed: () {
                                _fetchJobPosts(search: _searchController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE65100),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 34,
                                  vertical: 14,
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'ស្វែងរក',
                                style: GoogleFonts.notoSansKhmer(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Filter Chips
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FilterChipWidget(
                                  icon: Icons.location_on_outlined,
                                  label: 'ទីតាំង',
                                  onTap: () =>
                                      _showLocationFilter(_allProvinces),
                                ),
                                const SizedBox(width: 8),
                                FilterChipWidget(
                                  icon: Icons.work_outline,
                                  label: 'ប្រភេទការងារ',
                                  onTap: () =>
                                      _showWorkTypeFilter(_allWorkTypes),
                                ),
                                const SizedBox(width: 8),
                                FilterChipWidget(
                                  icon: Icons.trending_up,
                                  label: 'បទពិសោធន៍',
                                  onTap: () => _showExperienceLevelFilter(
                                    _allExperienceLevels,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.tune),
                            color: Colors.white,
                            iconSize: 20,
                            onPressed: () {
                              // Clear all filters
                              setState(() {
                                _selectedProvince = null;
                                _selectedWorkType = null;
                                _selectedExperienceLevel = null;
                              });
                              _fetchJobPosts(search: _searchController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Job List
          Expanded(
            child: Consumer<JobPostProvider>(
              builder: (context, provider, child) {
                return provider.jobPostListResponse.when(
                  empty: () => Center(
                    child: Text(
                      'រកមិនឃើញការងារ',
                      style: GoogleFonts.notoSansKhmer(),
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text('មានអ្វីមួយកើតមានកំហុស', textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _fetchJobPosts(),
                          child: Text(
                            'សាកល្បងម្ដងទៀត',
                            style: GoogleFonts.notoSansKhmer(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  success: (data) {
                    final jobs = data.results;
                    if (jobs.isEmpty) {
                      return Center(
                        child: Text(
                          'រកមិនឃើញការងារ',
                          style: GoogleFonts.notoSansKhmer(),
                        ),
                      );
                    }
                    print(
                      'Job lengthhhhhhhhhhhhhhhhhhhhhhhhhhhhh: ${jobs.length}',
                    );
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: jobs.length,

                      itemBuilder: (context, index) {
                        return JobFeedCard(
                          job: jobs[index],
                          isBookmarked: bookmarkedJobs.contains(index),
                          onBookmarkTap: () => _toggleBookmark(index),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
