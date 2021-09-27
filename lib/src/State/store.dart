import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:testapp/src/State/contact.reducers.dart';
import 'package:testapp/src/State/contact.epics.dart';

Store<ContactState> createStore() {
  final epics = combineEpics<ContactState>([
    getContactsEpic,
    addContactEpic,
    updateContactEpic,
    selectContactEpic,
    processVisionEpic,
  ]);
  var epicMiddleware = new EpicMiddleware(epics);
  return Store<ContactState>(
    contactReducer,
    initialState: ContactState.initial(),
    middleware: [epicMiddleware],
  );
}
