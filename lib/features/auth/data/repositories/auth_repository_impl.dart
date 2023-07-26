import 'package:dartz/dartz.dart';
import 'package:untitled/features/auth/data/sources/auth_local_datasource.dart';
import 'package:untitled/features/auth/data/sources/auth_remote_datasource.dart';
import 'package:untitled/features/auth/domain/entities/User.dart';
import 'package:untitled/features/auth/domain/repositories/auth_repository.dart';
import 'package:untitled/utils/failure.dart';

class AuthRepository extends IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepository(this._authRemoteDataSource, this._authLocalDataSource);

  //TODO: override the login method to be able to login with the remote api and save the login token via local db

  @override
  Future<Either<Failure, User>> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
