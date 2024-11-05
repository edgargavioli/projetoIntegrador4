import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget{
  final String title;
  final String message;
  
    const CustomNotification({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  _CustomNotificationState createState()=> _CustomNotificationState();
}
class _CustomNotificationState extends State<CustomNotification>{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(15.0),
        ),
          color: Colors.amber.shade600,
          margin: const EdgeInsets.symmetric(vertical:5, horizontal: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: SizedBox(width:double.infinity, height: 100,
             child : 
              Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                     ),
                    ),
                  ],
                 ),
                ),
                const Icon(Icons.error_outline,
                color: Colors.redAccent,
                size: 30,
                ),
              ],
              ),
            ),
          ),
        ),
    );
    
  }
}