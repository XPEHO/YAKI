// Mocks generated by Mockito 5.4.2 from annotations
// in yaki/test/unit/data/repositories/declaration_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:retrofit/retrofit.dart' as _i2;
import 'package:yaki/data/models/declaration_model.dart' as _i5;
import 'package:yaki/data/sources/remote/declaration_api.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHttpResponse_0<T> extends _i1.SmartFake
    implements _i2.HttpResponse<T> {
  _FakeHttpResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DeclarationApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeclarationApi extends _i1.Mock implements _i3.DeclarationApi {
  MockDeclarationApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.HttpResponse<dynamic>> getDeclaration(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDeclaration,
          [id],
        ),
        returnValue: _i4.Future<_i2.HttpResponse<dynamic>>.value(
            _FakeHttpResponse_0<dynamic>(
          this,
          Invocation.method(
            #getDeclaration,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse<dynamic>>);

  @override
  _i4.Future<_i2.HttpResponse<dynamic>> create(
    List<_i5.DeclarationModel>? declaration,
    String? mode,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [
            declaration,
            mode,
          ],
        ),
        returnValue: _i4.Future<_i2.HttpResponse<dynamic>>.value(
            _FakeHttpResponse_0<dynamic>(
          this,
          Invocation.method(
            #create,
            [
              declaration,
              mode,
            ],
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse<dynamic>>);
}
