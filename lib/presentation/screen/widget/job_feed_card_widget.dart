// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_feed/model/jp_model.dart';

class JobFeedCard extends StatelessWidget {
  final JobPost job;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const JobFeedCard({
    super.key,
    required this.job,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    print("Company Logoooooooooooo ${job.company!.logoUrl}");
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: job.company?.logoUrl?.isNotEmpty == true
                        ? Image.network(
                            job.company!.logoUrl!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/company_logo.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                // Company Name and Industry
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.company?.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.company?.specialize ?? '',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Bookmark Icon
                GestureDetector(
                  onTap: onBookmarkTap,
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked
                        ? const Color(0xFF006B5A)
                        : Colors.grey[400],
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Job Role Label
            Text(
              'តំណែងការងារ',
              style: GoogleFonts.notoSansKhmer(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            // Job Title
            Text(
              job.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Category Label
            Text(
              'ជំនាញការងារ',
              style: GoogleFonts.notoSansKhmer(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            // Category
            Text(
              job.skills ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            // Location and Job Type Row
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  job.address?.province?.name ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(width: 8),
                Text('•', style: TextStyle(color: Colors.grey[400])),
                const SizedBox(width: 8),
                Text(
                  job.workType,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(width: 8),
                Text('•', style: TextStyle(color: Colors.grey[400])),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    job.experienceLevel,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Divider
            Divider(color: Colors.grey[200], height: 1),
            const SizedBox(height: 12),
            // Footer Row
            Row(
              children: [
                Icon(Icons.people_outline, size: 18, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  '${job.applyRecordCount} បេក្ខជន',
                  style: GoogleFonts.notoSansKhmer(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  job.postingDate,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
