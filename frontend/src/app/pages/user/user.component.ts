import { Component, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { User } from 'app/model/user';
import { UserAccount } from 'app/model/user-accunt';
import { AuthService } from 'app/service/auth.service';
import { UserService } from 'app/service/user.service';
import { error } from 'console';
import { ConfirmationDialog } from '../confirmation-dialog/confirmation-dialog.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
    selector: 'user-cmp',
    moduleId: module.id,
    templateUrl: 'user.component.html'
})

export class UserComponent implements OnInit{

    user: User = new User();
    userId: string;
    userAccount: UserAccount = new UserAccount();
    updatedUser: User = new User();
    userRoleId: string;

    constructor(private userService: UserService, private authService: AuthService, 
        private router: Router, private snackBar: MatSnackBar,private dialog: MatDialog
    ) {}

    ngOnInit(){
        this.userId = this.authService.getSessionUserId();
        this.userService.getGuideById(this.userId).subscribe(data =>{
            this.user = data;
            this.change(data);
        })
    }

    change(data) {
        this.userAccount = data.account;
        this.userRoleId = data.role.id;
    }

    updateUser(){
        this.userService.register(this.updatedUser).subscribe(data => {
            console.log(data);
        },error => console.log(error))
    }

    onSubmit() {
      this.updatedUser.id = this.user.id;
      this.updatedUser.email = this.user.email;
      this.updatedUser.firstName = this.user.firstName;
      this.updatedUser.lastName = this.user.lastName;
      this.updatedUser.address = this.user.address;
      this.updatedUser.address = this.user.address;
      this.updatedUser.age = this.user.age;
      this.updatedUser.phone = this.user.phone;
      this.updatedUser.country = this.user.country;
      this.updatedUser.roleId = this.userRoleId;
      this.updatedUser.update = "update";
      this.updateUser();
    }

    openDialog(id: string) {
        const dialogRef = this.dialog.open(ConfirmationDialog, {
          data: {
            message: 'Are you sure you want to delete this account?',
            buttonText: {
              ok: 'Yes',
              cancel: 'No',
            },
          },
        });
    
        dialogRef.afterClosed().subscribe((confirmed: boolean) => {
          if (confirmed) {
            this.deleteUser(id)
            this.snackBar.open('User deleted!', 'Fechar', {
              duration: 2000,
            });
          }
        });
      }

    deleteUser(id: string) {
        this.userService.deleteUser(id).subscribe(data => {
            console.log(data)
              this.navigateLogin();
        }, error => console.log(error))
    }

    navigateLogin() {
        this.router.navigate(['auth'])
    }
}
