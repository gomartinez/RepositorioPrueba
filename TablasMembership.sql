TABLAAAAAAAAAAAAAAS DE MIERDA
siguen siendo unas tablas de mierda
aaaaaaaaaaaa
eeeee


iiii

/****** Object:  Table [dbo].[Applications]    Script Date: 05/13/2012 21:59:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Applications](
	[ApplicationName] [nvarchar](235) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Users]    Script Date: 05/13/2012 21:51:20 ******/


CREATE TABLE [dbo].[Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [UserApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO

ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [UserApplication]
GO


/****** Object:  Table [dbo].[Roles]    Script Date: 05/13/2012 21:52:53 ******/
CREATE TABLE [dbo].[Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [RoleApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO

ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleApplication]
GO

/****** Object:  Table [dbo].[Profiles]    Script Date: 05/13/2012 21:53:36 ******/
CREATE TABLE [dbo].[Profiles](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [nvarchar](4000) NOT NULL,
	[PropertyValueStrings] [nvarchar](4000) NOT NULL,
	[PropertyValueBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO

ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [UserProfile]
GO



/****** Object:  Table [dbo].[Memberships]    Script Date: 05/13/2012 21:59:25 ******/

CREATE TABLE [dbo].[Memberships](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
	[Comment] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO

ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipApplication]
GO

ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO

ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipUser]
GO

/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 05/13/2012 22:00:08 ******/

CREATE TABLE [dbo].[UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO

ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleRole]
GO

ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO

ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleUser]
GO

