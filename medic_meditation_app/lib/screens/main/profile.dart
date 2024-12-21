import 'package:flutter/material.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
    
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 40), // Space for status bar
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(ImageConsts.AVATAR),
          ),
          SizedBox(height: 16),
          Text(
            'Ravi Kumar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Ranchi, India',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
          SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'STATS'),
              Tab(text: 'ACHIEVEMENTS'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(
                  child: Text(
                    'Achievements coming soon!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Achievements coming soon!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
