import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/controllers/employee_controller.dart';
import 'package:lastest_broo/utils/apwrite_constant.dart';
import 'package:lastest_broo/view/addEmployee_page.dart';

class EmployeePage extends GetView<EmployeeController> {

  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee'),
      ),
      body: Center(
        child: controller.obx(
            (state) => ListView.separated(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 10,
                      color: Colors.grey,
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              '${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeeBucketId}/files/${state[index].image}/view?project=${AppwriteConstants.projectId}',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      title: Text(
                        state[index].name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        state[index].department,
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.moveToEditEmployee(state[index]);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                controller.deleteEmployee(state[index]);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount: state!.length,
                ),
            onLoading: Center(child: CircularProgressIndicator()),
            onError: (error) => Center(
                  child: Text(error!),
                ),
            onEmpty: const Center(
              child: Text('No post fount'),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to AddEmployee when FloatingActionButton is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployee()),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/sell');
              break;
            case 2:
              Navigator.pushNamed(context, '/employee');
              break;
            case 3:
              Navigator.pushNamed(context, '/webViewPage');
              break;
            case 4:
              Navigator.pushNamed(context, '/dashboard');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_rounded),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
