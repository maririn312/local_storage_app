// // ignore_for_file: avoid_print, sized_box_for_whitespace, unused_element, unnecessary_this, missing_return

// import 'package:flutter/material.dart';
// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _ProductListScreenState();
//   }
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   List<ProductCategoryEntity> productCategoryData = [];
//   List<ProductCategoryEntity> productCategoryIdData = [];
//   List<ProductCategoryEntity> categoryParent = [];

//   String query = '';
//   /* ================================================================================== */
//   /* ================================================================================== */
//   @override
//   void initState() {
//     getProductList();
//     super.initState();
//   }

//   /* ================================================================================== */
//   /* ================================================================================== */
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   getProductList() async {
//     List<ProductCategoryEntity> productCategory =
//         await DBProvider.db.getProductCagegory();
//     setState(() {
//       productCategoryData.addAll(productCategory);
//     });
//   }

//   Future<String> getPartName(int id) async {
//     final DBProvider _databaseService = DBProvider();
//     final parentName = await _databaseService.categName(id);
//     return parentName.name;
//   }

//   /* ================================================================================== */
//   /* ================================================================================== */
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [_buildSearch(), _buildListBoxGroup()],
//       )),
//     );
//   }

//   /* ================================================================================== */
//   /* ================================================================================== */
//   Widget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       foregroundColor: Colors.black,
//       elevation: 0,
//       centerTitle: false,
//     );
//   }

//   void searchData(String query) async {
//     List<ProductCategoryEntity> saleOrder =
//         await DBProvider.db.getProductCagegory();
//     final data = saleOrder.where((datas) {
//       final titleLower = datas.name.toLowerCase();
//       final parentIdLower = datas.parentId.toString();
//       final codeLower = datas.code.toString();
//       final searchLower = query.toLowerCase();

//       return titleLower.contains(searchLower) ||
//           parentIdLower.contains(searchLower) ||
//           codeLower.contains(searchLower);
//     }).toList();

//     setState(() {
//       this.query = query;
//       this.productCategoryData = data;
//     });
//   }

//   Widget _buildSearch() => SearchWidget(
//         text: query,
//         hintText: Language.LABEL_SEARCH,
//         onChanged: searchData,
//       );
//   /* ================================================================================== */
//   /* ================================================================================== */

//   Widget _buildListBoxGroup() {
//     double height = MediaQuery.of(context).size.height - 160;
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       height: height,
//       child: _buildScreen(),
//     );
//   }

//   Widget _buildScreen() {
//     for (int i = 0; i < productCategoryData.length; i++) {
//       print('end yu irj bn ${productCategoryData[i].id}');
//       categoryParent.add(productCategoryData[i]);
//     }
//     print('end yu ireh bile ${categoryParent.last.id}');
//     return ListView.builder(
//       itemCount: productCategoryData.length,
//       itemBuilder: (_, index) {
//         for (int i = 0; i < productCategoryData.length; i++) {
//           return GestureDetector(
//             onTap: () {},
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft,
//                         colors: [
//                           Color.fromARGB(206, 226, 105, 145),
//                           Color.fromRGBO(104, 26, 81, 0.9),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   _buildText(
//                                       '${Language.LABEL_CATEGORY_NAME}:'),
//                                   _buildText(
//                                     '${Language.LABEL_PRODUCT_LIST_PARENT}:',
//                                   ),
//                                   _buildText(
//                                     '${Language.LABEL_CATEGORY_CODE}:',
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 _buildText(productCategoryData[index].name),
//                                 FutureBuilder<String>(
//                                   future: getPartName(
//                                       productCategoryData[index].parentId),
//                                   builder: (context, parentName) {
//                                     return _buildText(parentName.data);
//                                   },
//                                 ),
//                                 _buildText(productCategoryData[index].code),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildText(String text) {
//     return Text(
//       text ?? "Хоосон байна",
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//       ),
//     );
//   }
// }
