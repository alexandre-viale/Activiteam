import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tp2_dev_mobile/enums/activities_category.dart';
import 'package:tp2_dev_mobile/model/activity.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activities_slide/widgets/activity_details_page.dart';

class ActivitiesSlide extends StatefulWidget {
  const ActivitiesSlide({super.key});

  @override
  State<ActivitiesSlide> createState() => _ActivitiesSlideState();
}

class _ActivitiesSlideState extends State<ActivitiesSlide> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesNotifier>(
      builder: (context, activitiesNotifier, child) {
        List<Activity> activities = activitiesNotifier.activities;
        if (activities.isEmpty) {
          List<Activity> fakeActivitiesForLoading = List.generate(
              10,
              (index) => Activity(
                    id: 'Loading',
                    category: ActivitiesCategory.sport,
                    minimumPeople: 1,
                    title: 'Loading',
                    imageLink: null,
                    place: 'Loading',
                    price: 0,
                  ));
          return Skeletonizer(
            enabled: true,
            child: ActivitiesList(activities: fakeActivitiesForLoading),
          );
        }
        return ActivitiesList(activities: activities);
      },
    );
  }
}

class ActivitiesList extends StatefulWidget {
  const ActivitiesList({super.key, required this.activities});
  final List<Activity> activities;
  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.activities.length,
      itemBuilder: (context, index) {
        Activity activity = widget.activities[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            leading: Hero(
              tag: 'activity_image_${activity.title}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: activity.imageLink != null
                    ? Image.network(
                        activity.imageLink!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                      ),
              ),
            ),
            title: Text(
              activity.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4.0),
                    Text(
                      activity.place,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.euro_symbol, size: 16),
                    const SizedBox(width: 4.0),
                    Text(
                      activity.price.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ActivityDetailsPage(activity: activity),
                ),
              );
            },
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
