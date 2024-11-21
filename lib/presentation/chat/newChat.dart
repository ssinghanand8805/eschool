import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

class NewConversationsPage extends StatefulWidget {
  @override
  _NewConversationsPageState createState() => _NewConversationsPageState();
}

class _NewConversationsPageState extends State<NewConversationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title:  Text("New Conversations / Groups",style: theme.textTheme.bodyMedium,),
        bottom: TabBar(
          controller: _tabController,
          //  isScrollable: true,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "My Contacts"),
            Tab(text: "New Conversation"),
            Tab(text: "Groups"),
            Tab(text: "Blocked Users"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyContactsTab(),
          _buildNewConversationTab(),
          _buildGroupsTab(),
          _buildBlockedUsersTab(),
        ],
      ),
    );
  }

  Widget _buildMyContactsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: controller,
                  hint: 'Search...',
                  title: 'Search',
                ),
              ),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: "Male", child: Text("Male")),
                  const PopupMenuItem(value: "Female", child: Text("Female")),
                  const PopupMenuItem(value: "Online", child: Text("Online")),
                  const PopupMenuItem(value: "Offline", child: Text("Offline")),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1, // Replace with actual contact count
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text("user1"),
                subtitle: const Text("sam@sam.com"),
                trailing: IconButton(
                  icon: const Icon(Icons.message, color: Colors.blue),
                  onPressed: () {
                    // Action for messaging
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewConversationTab() {
    return Center(
      child: Text(
        "New Conversation",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildGroupsTab() {
    return Center(
      child: Text(
        "Groups",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildBlockedUsersTab() {
    return Center(
      child: Text(
        "Blocked Users",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
