import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/provider/students_app_provider/student_profile_provider.dart';
import 'package:quran_tdress/student_app/profile/edit_peofile_screen.dart';

class ProfileScreenStudents extends StatefulWidget {
  const ProfileScreenStudents({super.key});

  @override
  State<ProfileScreenStudents> createState() => _ProfileScreenStudentsState();
}

class _ProfileScreenStudentsState extends State<ProfileScreenStudents> {
  @override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<StudentProfileProvider>(context, listen: false).fetchprofile();
  });
}

  @override
  Widget build(BuildContext context) {
    // final profileprovider = Provider.of<StudentProfileProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text("Profile"),
      // ),
      body: Consumer<StudentProfileProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (profileProvider.user.isEmpty) {
            return const Center(child: Text("No Data"));
          }

          return ListView.builder(
              itemCount: profileProvider.user.length,
              itemBuilder: (context, index) {
                final profiles = profileProvider.user[index];
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width:double.infinity,
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        // color: Colors.blue,
                        child: Column(
                          children: [
                        
                          
                          CircleAvatar(
                            radius: 40,
                            // backgroundColor: Colors.purple,
                            backgroundImage:
                                NetworkImage(profiles.profile.profile_photo_url),
                          ),
                        
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          profiles.name ,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                          Text(
                          profiles.email,
                          style: const TextStyle(fontSize: 17),
                        ),

                        const SizedBox(height: 13,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditProfileScreen(
                              name: profiles.name,
                              studentid: profiles.userid,
                              email: profiles.email,
                              phone: profiles.profile.phone,
                              birth: profiles.profile.birth_date,
                              country: profiles.profile.country,
                            )));

                          },
                          child: const  TRoundedContainer(
                                        width: 260,
                                        height: 45,
                                        padding:  EdgeInsets.only(top: 7,left: 16),
                                        backgroundColor:  Colors.purple,
                                        child: Row(children:[ 
                                          Text("Edit profile information",style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),
                                          SizedBox(width: 13,),
                                          Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 19,)
                                        ]
                                          ),
                                      ),
                        ),
                        
                        const SizedBox(height: 30,),
                        
                          ]
                        ),
                      ),
                
                      const Row(
                        children:[
                          SizedBox(width: 7,),
                          Text("Personel Information",style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),),
                        ]
                      ),
                            const Divider(),
                      Row(
                        children: [
                          const SizedBox(width: 7),
                          const Text("Sex :",style: TextStyle(fontSize: 17),),
                          const SizedBox(width: 4,),
                          Text(profiles.profile.sex,style: const TextStyle(fontSize: 17),),
                          const SizedBox(width: 75,),
                          const Text("Birth date :",style: TextStyle(fontSize: 17),),
                          const SizedBox(width: 4,),
                          Text(profiles.profile.birth_date,style: const TextStyle(fontSize: 17),),
                          
                        ],
                      ),
                      
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const SizedBox(width: 7),
                          const Text("Country :",style: TextStyle(fontSize: 17),),
                          Text(profiles.profile.country,style: const TextStyle(fontSize: 17),),
                          const SizedBox(width: 40,),
                          const Text("Phone number :",style: TextStyle(fontSize: 17),),
                          Text(profiles.profile.phone,style: const TextStyle(fontSize: 17),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const SizedBox(width: 7),
                          const Text("Age :",style: TextStyle(fontSize: 17),),
                          Text(profiles.profile.age.toString(),style: const TextStyle(fontSize: 17),),
                          // const SizedBox(width: 40,),
                          // const Text("Phone number :",style: TextStyle(fontSize: 17),),
                          // Text(profiles.profile.phone,style: const TextStyle(fontSize: 17),),
                        ],
                      ),

                      const Divider(),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}


