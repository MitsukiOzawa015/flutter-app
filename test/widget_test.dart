// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/page/post/bloc/post_bloc.dart';
import 'package:practice_app/page/story/bloc/story_bloc.dart';
import 'package:practice_app/use_case/post_use_case.dart';
import 'package:practice_app/use_case/story_use_case.dart';

import 'package:practice_app/main.dart';

void main() {
  testWidgets('App loads and displays Instagram UI', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (BuildContext context) => PostBloc(postUseCase: PostUseCase())),
        BlocProvider<StoryBloc>(create: (BuildContext context) => StoryBloc(storyUseCase: StoryUseCase()))
      ], 
      child: const MyApp()
    ));

    // Verify that the Insta app bar is displayed
    expect(find.text('Insta'), findsOneWidget);
    
    // Verify that the app doesn't crash during initialization
    await tester.pumpAndSettle();
  });
}
