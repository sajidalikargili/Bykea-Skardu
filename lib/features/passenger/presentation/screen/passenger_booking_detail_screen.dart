import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
import 'package:flutter/material.dart';

class PassengerBookingDetailScreen extends StatelessWidget {
  final RideModel ride;

  const PassengerBookingDetailScreen({
    super.key,
    required this.ride,
  });

  Color getStatusColor() {
    switch (ride.status) {
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "accepted":
        return Colors.orange;
      case "ongoing":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget infoTile({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: (iconColor ?? Colors.green).withOpacity(.12),
            child: Icon(
              icon,
              color: iconColor ?? Colors.green,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("Booking Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            /// Route Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [

                  const Icon(
                    Icons.directions_bike,
                    size: 70,
                    color: Colors.green,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "${ride.pickupStand} → ${ride.distination}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor().withOpacity(.15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      ride.status.toUpperCase(),
                      style: TextStyle(
                        color: getStatusColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Details Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [

                  infoTile(
                    icon: Icons.location_on,
                    title: "Pickup",
                    value: ride.pickupStand,
                  ),

                  Divider(),

                  infoTile(
                    icon: Icons.flag,
                    title: "Destination",
                    value: ride.distination,
                    iconColor: Colors.orange,
                  ),

                  Divider(),

                  infoTile(
                    icon: Icons.payments,
                    title: "Fare",
                    value: "PKR ${ride.fare ?? '0'}",
                    iconColor: Colors.green,
                  ),

                  Divider(),

                  infoTile(
                    icon: Icons.person,
                    title: "Rider",
                    value: ride.riderName ?? "Not Assigned",
                    iconColor: Colors.blue,
                  ),

                  Divider(),

                  infoTile(
                    icon: Icons.phone,
                    title: "Phone",
                    value: ride.riderPhone ?? "N/A",
                    iconColor: Colors.teal,
                  ),

                  Divider(),

                  infoTile(
                    icon: Icons.confirmation_number,
                    title: "Booking ID",
                    value: ride.rideId,
                    iconColor: Colors.deepPurple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  "Back",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}